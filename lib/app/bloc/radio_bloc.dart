import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tune_radio/app/bloc/radio_state.dart';
import 'package:tune_radio/app/helpers/notification_helper.dart';
import 'package:tune_radio/app/models/station.dart';
import 'package:tune_radio/app/repository/radio_repository.dart';

class RadioBloc extends Cubit<RadioState> {
  static const String playerEventChannel = "playerActions";

  RadioRepository repository;
  Station _current =
      Station(changeuuid: "", stationuuid: "", name: "", url: "");

  final _audioPlayer = AudioPlayer();

  bool _isLoaded = false;

  RadioBloc({required this.repository}) : super(InitialState()) {
    audioEvents();
    notificationEvents();
  }

  // functions

  void audioEvents() {
    _audioPlayer.playerStateStream.listen((event) {
      switch (event.processingState) {
        case ProcessingState.loading:
          emit(LoadingState());
          _isLoaded = false;
          break;
        case ProcessingState.ready:
          emit(PlayingState(event.playing, _current));

          if (_isLoaded) {
            NotificationHelper.notifyPlayState(event.playing);
          } else {
            NotificationHelper.notifyStationChange(_current);
          }

          _isLoaded = true;

          break;
        default:
      }
    });

    _audioPlayer.volumeStream.listen((event) {
      emit(VolumeState(event));
    });
  }

  void play(Station station) async {
    if (station.stationuuid != _current.stationuuid) {
      _audioPlayer.stop();
      _setUrl(station.urlResolved.isEmpty ? station.url : station.urlResolved);
      _current = station;
    }

    _audioPlayer.playing ? _pause() : _play();
  }

  void setVolume(double volume) {
    _audioPlayer.setVolume(volume);
  }

  void stop() {
    _audioPlayer.stop();
  }

  void _play() {
    _audioPlayer.play();
  }

  void _pause() {
    _audioPlayer.pause();
  }

  void _setUrl(String url) async {
    try {
      await _audioPlayer.setUrl(url);
    } catch (e) {
      emit(ErrorState());
      rethrow;
    }
  }

  void notificationEvents() async {
    const stream = EventChannel(playerEventChannel);
    stream.receiveBroadcastStream().listen((event) {
      _audioPlayer.playing ? _pause() : _play();
    });
  }
}
