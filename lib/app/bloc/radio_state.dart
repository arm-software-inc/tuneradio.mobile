import 'package:equatable/equatable.dart';
import 'package:tune_radio/app/models/station.dart';

abstract class RadioState extends Equatable {}

class InitialState extends RadioState {
  @override
  List<Object> get props => [];
}

class LoadingState extends RadioState {
  @override
  List<Object?> get props => [];
}

class PlayingState extends RadioState {
  PlayingState(this.playing, this.station);

  final bool playing;
  final Station station;

  @override
  List<Object> get props => [playing, station];
}

class VolumeState extends RadioState {
  VolumeState(this.volume);

  final double volume;

  @override
  List<Object?> get props => [volume];
}

class ErrorState extends RadioState {
  @override
  List<Object?> get props => [];
}
