import 'package:bloc/bloc.dart';
import 'package:tune_radio/app/pages/explorer/history/history_state.dart';
import 'package:tune_radio/app/repository/history_repository.dart';

class HistoryBloc extends Cubit<HistoryState> {
  final HistoryRepository _repository;

  HistoryBloc(this._repository) : super(InitialState());

  void fetch() async {
    emit(LoadingState());
    final histories = await _repository.getAll() ?? [];
    emit(LoadedState(histories));
  }

  void remove(int historyId) async {
    await _repository.delete(historyId);
    fetch();
  }
}
