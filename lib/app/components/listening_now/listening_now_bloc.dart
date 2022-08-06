import 'package:bloc/bloc.dart';
import 'package:tune_radio/app/components/listening_now/listening_now_state.dart';
import 'package:tune_radio/app/repository/radio_repository.dart';

class ListeningNowBloc extends Cubit<ListeningNowState> {
  ListeningNowBloc(this._repository) : super(InitialState()) {
    _fetch();
  }

  final RadioRepository _repository;

  void _fetch() async {
    emit(LoadingState());
    final stations = await _repository.fetchListeningNow();
    emit(LoadedState(
        stations.where((value) => value.favicon.isNotEmpty).toList()));
  }
}
