import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_radio/app/bloc/radio_bloc.dart';
import 'package:tune_radio/app/bloc/radio_state.dart';
import 'package:tune_radio/app/components/favorite_button/favorite_button_component.dart';
import 'package:tune_radio/app/components/loading/loading_component.dart';
import 'package:tune_radio/app/helpers/constants.dart';
import 'package:tune_radio/app/models/station.dart';
import 'package:tune_radio/app/models/station_collection.dart';
import 'package:tune_radio/app/pages/collection/collections_bloc.dart';
import 'package:tune_radio/app/pages/collection/collections_state.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  PlayerPageState createState() => PlayerPageState();
}

class PlayerPageState extends State<PlayerPage> {
  late RadioBloc _blocRadio;
  late CollectionsBloc _collectionsBloc;

  late Station _station;

  @override
  Widget build(BuildContext context) {
    _blocRadio = context.read<RadioBloc>();
    _collectionsBloc = context.read<CollectionsBloc>();
    _collectionsBloc.fetch();

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: _content(),
    );
  }

  Widget _content() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: BlocBuilder<RadioBloc, RadioState>(
          buildWhen: (prev, curr) => curr is! VolumeState,
          builder: (_, state) {
            if (state is PlayingState) {
              _station = state.station;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 10 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(_station.favicon),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _station.name,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _station.formattedTags,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  Text("${_station.votes} curtidas"),
                  _controls(state),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            );
          }),
    );
  }

  Widget _controls(PlayingState playingState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: IconButton(
            onPressed: () => _showCollections(),
            icon: const Icon(Icons.playlist_add),
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: () {
              _blocRadio.play(playingState.station);
            },
            icon: Icon(
              playingState.playing
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              color: Colors.white,
            ),
            iconSize: 72,
          ),
        ),
        Expanded(
          child: FavoriteButtonComponent(station: _station),
        ),
      ],
    );
  }

  _showCollections() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).backgroundColor,
      builder: (context) => Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const Text(Constants.selectCollection),
          ),
          Expanded(
            child: BlocBuilder<CollectionsBloc, CollectionsState>(
                bloc: _collectionsBloc,
                builder: (context, state) {
                  if (state is LoadedState) {
                    return _collectionsList(state.collections);
                  }

                  return const LoadingComponent();
                }),
          ),
        ],
      ),
    );
  }

  Widget _collectionsList(List<StationCollection> collections) {
    return ListView.builder(
      itemCount: collections.length,
      itemBuilder: (_, index) {
        return ListTile(
          onTap: () {
            _collectionsBloc.addStation(
                collections[index].id!, _station.stationuuid);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          },
          title: Text(collections[index].name),
          leading: const Icon(Icons.list_rounded),
        );
      },
    );
  }

  final snackbar = const SnackBar(
    content: Text(Constants.stationCollectionAdded,
        style: TextStyle(color: Colors.white)),
    duration: Duration(seconds: 2),
  );
}
