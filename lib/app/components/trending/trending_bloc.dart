import 'package:bloc/bloc.dart';
import 'package:radiao/app/components/trending/trending_state.dart';
import 'package:radiao/app/repository/radio_repository.dart';

class TrendingBloc extends Cubit<TrendingState> {
  TrendingBloc(this._repository) : super(InitialState()) {
    _fetch();
  }

  final RadioRepository _repository;

  void _fetch() async {
    emit(LoadingState());
    final stations = await _repository.fetchTrending();
    emit(LoadedState(stations.where((value) => value.favicon.isNotEmpty).toList()));
  }
}