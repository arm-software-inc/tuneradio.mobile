import 'package:bloc/bloc.dart';
import 'package:tune_radio/app/helpers/sqlite_helper.dart';
import 'package:tune_radio/app/pages/loading/loading_state.dart';

class LoadingBloc extends Cubit<LoadingState> {
  LoadingBloc() : super(InitialState()) {
    loadDb();
  }

  void loadDb() async {
    await SqliteHelper.setupAndOpenDatabase();
    emit(LoadedState());
  }
}
