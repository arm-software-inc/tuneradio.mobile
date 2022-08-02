import 'package:equatable/equatable.dart';
import 'package:tune_radio/app/models/station.dart';

abstract class ListeningNowState extends Equatable {}

class InitialState extends ListeningNowState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends ListeningNowState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends ListeningNowState {
  LoadedState(this.stations);

  final List<Station> stations;

  @override
  List<Object?> get props => [...stations];
}
