import 'package:bloc/bloc.dart';
import 'package:tune_radio/app/components/popular/popular_state.dart';
import 'package:tune_radio/app/repository/radio_repository.dart';

class PopularBloc extends Cubit<PopularState> {
  PopularBloc(this._repository) : super(InitialState()) {
    _fetch();
  }

  final RadioRepository _repository;

  void _fetch() async {
    emit(LoadingState());
    final stations = await _repository.fetchPopular();
    emit(LoadedState(
        stations.where((value) => value.favicon.isNotEmpty).toList()));
  }
}
