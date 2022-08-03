import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radiao/app/pages/favorite/bloc/favorite_state.dart';
import 'package:radiao/app/repository/favorite_repository.dart';
import 'package:radiao/app/repository/radio_repository.dart';

class FavoriteBloc extends Cubit<FavoriteState> {
  final FavoriteRepository favoriteRepository;
  final RadioRepository radioRepository;
  
  FavoriteBloc(this.favoriteRepository, this.radioRepository) : super(LoadingFavoritesState());

  void fetch() async {
    final stationuuids = await favoriteRepository.fetch();

    if (stationuuids.isEmpty) {
      emit(LoadedFavoritesState(const []));
      return;
    }
    
    final stations = await radioRepository.fetchByIds(stationuuids);

    emit(LoadedFavoritesState(stations));
  }  
}