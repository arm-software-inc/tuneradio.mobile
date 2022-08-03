import 'package:equatable/equatable.dart';
import 'package:radiao/app/models/station.dart';

abstract class FavoriteState extends Equatable {}

class LoadingFavoritesState extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class LoadedFavoritesState extends FavoriteState {
  final List<Station> stations;

  LoadedFavoritesState(this.stations);

  @override
  List<Object?> get props => [...stations];
}