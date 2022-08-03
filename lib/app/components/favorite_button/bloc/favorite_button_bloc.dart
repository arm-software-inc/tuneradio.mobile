import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_radio/app/components/favorite_button/bloc/favorite_button_state.dart';
import 'package:tune_radio/app/repository/favorite_repository.dart';
import 'package:tune_radio/app/repository/radio_repository.dart';

class FavoriteButtonBloc extends Cubit<FavoriteButtonState> {
  final FavoriteRepository favoriteRepository;
  final RadioRepository radioRepository;

  FavoriteButtonBloc(this.favoriteRepository, this.radioRepository)
      : super(FavoriteState(false));

  void check(String stationuuid) async {
    final result = await favoriteRepository.check(stationuuid);
    emit(FavoriteState(result));
  }

  void favorite(String stationuuid) async {
    final result = await favoriteRepository.check(stationuuid);

    if (result) {
      favoriteRepository.remove(stationuuid);
    } else {
      radioRepository.vote(stationuuid);
      await favoriteRepository.add(stationuuid);
    }

    check(stationuuid);
  }
}
