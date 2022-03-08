import 'package:bloc/bloc.dart';
import 'package:radiao/app/helpers/sqlite_helper.dart';
import 'package:radiao/app/pages/loading/loading_state.dart';

class LoadingBloc extends Cubit<LoadingState> {
  LoadingBloc() : super(InitialState()) {
    loadDb();
  }

  void loadDb() async {
    await SqliteHelper.setupAndOpenDatabase();
    emit(LoadedState());
  }
}