import 'package:equatable/equatable.dart';

abstract class FavoriteButtonState extends Equatable {}

class FavoriteState extends FavoriteButtonState {
  final bool isFavorite;

  FavoriteState(this.isFavorite);
  
  @override
  List<Object?> get props => [isFavorite];
}