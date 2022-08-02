import 'package:bloc/bloc.dart';
import 'package:tune_radio/app/models/history.dart';
import 'package:tune_radio/app/models/station.dart';
import 'package:tune_radio/app/pages/explorer/explorer_state.dart';
import 'package:tune_radio/app/repository/history_repository.dart';
import 'package:tune_radio/app/repository/radio_repository.dart';

class ExplorerBloc extends Cubit<ExplorerState> {
  ExplorerBloc(this._repository, this._historyRepository)
      : super(InitialState());

  final RadioRepository _repository;
  final HistoryRepository _historyRepository;

  void search(String text) async {
    emit(LoadingState());

    List<Station> results = [];

    await _historyRepository.create(History(value: text));

    if (text.startsWith("#")) {
      results = await _repository.fetchByTag(text.replaceAll("#", ""));
    } else {
      results = await _repository.searchStations(text);
    }

    results.isEmpty ? emit(ResultEmpty()) : emit(LoadedState(results));
  }

  void searchByTag(String tagname) async {
    emit(LoadingState());
    await _historyRepository.create(History(value: tagname));
    final results = await _repository.fetchByTag(tagname);
    results.isEmpty ? emit(ResultEmpty()) : emit(LoadedState(results));
  }

  void backToInitial() {
    emit(InitialState());
  }
}
