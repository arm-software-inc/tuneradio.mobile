import 'package:equatable/equatable.dart';
import 'package:tune_radio/app/models/station.dart';
import 'package:tune_radio/app/models/station_collection_item.dart';

abstract class CollectionState extends Equatable {}

class InitialState extends CollectionState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends CollectionState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends CollectionState {
  final List<StationCollectionItem> collections;
  final List<Station> stations;

  LoadedState(this.collections, this.stations);

  @override
  List<Object?> get props => [...collections, ...stations];
}
