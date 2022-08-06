import 'package:equatable/equatable.dart';
import 'package:tune_radio/app/models/station.dart';

abstract class ExplorerState extends Equatable {}

class InitialState extends ExplorerState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends ExplorerState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends ExplorerState {
  LoadedState(this.stations);

  final List<Station> stations;

  @override
  List<Object?> get props => [...stations];
}

class ResultEmpty extends ExplorerState {
  @override
  List<Object?> get props => [];
}
