import 'package:equatable/equatable.dart';
import 'package:radiao/app/models/station.dart';

abstract class PopularState extends Equatable {}

class InitialState extends PopularState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends PopularState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends PopularState {
  LoadedState(this.stations);

  final List<Station> stations;
  
  @override
  List<Object?> get props => [...stations];
}