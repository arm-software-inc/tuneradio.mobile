import 'package:equatable/equatable.dart';
import 'package:tune_radio/app/models/station_collection.dart';

abstract class CollectionsState extends Equatable {}

class InitialState extends CollectionsState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends CollectionsState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends CollectionsState {
  final List<StationCollection> collections;

  LoadedState(this.collections);

  @override
  List<Object?> get props => [...collections];
}
