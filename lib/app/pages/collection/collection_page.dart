import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radiao/app/components/loading/loading_component.dart';
import 'package:radiao/app/components/player/player_component.dart';
import 'package:radiao/app/components/station_card/station_card_component.dart';
import 'package:radiao/app/helpers/constants.dart';
import 'package:radiao/app/models/station.dart';
import 'package:radiao/app/pages/collection/collection_bloc.dart';
import 'package:radiao/app/pages/collection/collection_state.dart';
import 'package:radiao/app/pages/collection/collections_bloc.dart';

class CollectionPage extends StatefulWidget {
  final CollectionPageParams params;

  const CollectionPage({ Key? key, required this.params, }) : super(key: key);

  @override
  CollectionPageState createState() => CollectionPageState();
}

class CollectionPageState extends State<CollectionPage> {
  late CollectionBloc _bloc;
  late CollectionsBloc _collectionsBloc;

  @override
  Widget build(BuildContext context) {
    _collectionsBloc = context.read<CollectionsBloc>();
    _bloc = context.read<CollectionBloc>();
    _bloc.fetch(widget.params.collectionId);

    return Scaffold (
      appBar: AppBar(
        title: Text(widget.params.collectionName),
        actions: [
          IconButton(
            onPressed: () => _showEditCollection(), 
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => _showDeleteCollection(), 
            icon: const Icon(Icons.delete, color: Colors.red,),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CollectionBloc, CollectionState>(
                bloc: _bloc,
                builder: (_, state) {
                  if (state is LoadedState) {
                    return _stations(state.stations);
                  }
                  return const LoadingComponent();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: const PlayerComponent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stations(List<Station> stations) {
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (_, index) {
        return Dismissible(
          key: Key(stations[index].stationuuid),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _collectionsBloc.removeStation(stations[index].stationuuid);
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          },
          background: Container(
            color: Colors.red,
          ),
          child: StationCardComponent(
            station: stations[index],
          ),
        );
      },
    );
  }

  _showEditCollection() {
    final textController = TextEditingController(text: widget.params.collectionName);
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: const Text(Constants.editCollection),
        actions: [
          TextButton(
            onPressed: () {
              _collectionsBloc.update(widget.params.collectionId, textController.text);
              Navigator.of(context).popUntil((route) => route.isFirst);
            }, 
            child: const Text(Constants.ok),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: const Text(Constants.cancel),
          ),
        ],
        content: TextFormField(
          autofocus: true,
          controller: textController,
        ),
      ),
    );
  }

  _showDeleteCollection() {
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              _collectionsBloc.delete(widget.params.collectionId);
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text(Constants.yes),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(Constants.no, style: TextStyle(color: Colors.red),),
          ),
        ],
        title: const Text(Constants.deleteCollectionConfirm),
      ),
    );
  }

  final snackbar = const SnackBar(
    duration: Duration(seconds: 2),
    content: Text(Constants.stationCollectionRemoved, style: TextStyle(color: Colors.white)),
  );
}

class CollectionPageParams {
  final int collectionId;
  final String collectionName;

  CollectionPageParams(this.collectionId, this.collectionName);
}