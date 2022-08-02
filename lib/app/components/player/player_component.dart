import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radiao/app/bloc/radio_bloc.dart';
import 'package:radiao/app/bloc/radio_state.dart';
import 'package:radiao/app/custom_theme.dart';
import 'package:radiao/app/helpers/constants.dart';

class PlayerComponent extends StatefulWidget {
  const PlayerComponent({Key? key}) : super(key: key);

  @override
  PlayerComponentState createState() => PlayerComponentState();
}

class PlayerComponentState extends State<PlayerComponent> {
  RadioBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = context.read<RadioBloc>();
    return BlocBuilder<RadioBloc, RadioState>(
      bloc: _bloc,
      buildWhen: (prev, curr) => curr is! VolumeState,
      builder: (_, state) {
        if (state is PlayingState) {
          final station = state.station;
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/player");
            },
            child: ListTile(
              leading: _cover(station.favicon),
              title: Text(station.name),
              trailing: _playButton(state),
            ),
          );
        }

        if (state is LoadingState) {
          return const ListTile(
            title: Text(Constants.loading),
          );
        }

        if (state is ErrorState) {
          return const ListTile(
            title: Text(Constants.error),
          );
        }

        return Container();
      },
    );
  }

  Widget _playButton(PlayingState playingState) {
    return IconButton(
      splashRadius: 1,
      onPressed: () {
        _bloc?.play(playingState.station);
      },
      icon: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(42),
          gradient: LinearGradient(
            colors: CustomTheme.buttomGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Icon(
          playingState.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _cover(String coverUrl) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: FittedBox(
        child: coverUrl.isEmpty ? const Icon(Icons.radio) : Image.network(coverUrl),
      ),
    );
  }
}
