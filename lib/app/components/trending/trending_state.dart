import 'package:equatable/equatable.dart';
import 'package:radiao/app/models/station.dart';

abstract class TrendingState extends Equatable {}

class InitialState extends TrendingState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends TrendingState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends TrendingState {
  LoadedState(this.stations);

  final List<Station> stations;

  @override
  List<Object?> get props => [...stations];
}