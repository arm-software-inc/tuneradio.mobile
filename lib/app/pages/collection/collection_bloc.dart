import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radiao/app/pages/collection/collection_state.dart';
import 'package:radiao/app/repository/collection_item_repository.dart';
import 'package:radiao/app/repository/radio_repository.dart';

class CollectionBloc extends Cubit<CollectionState> {
  final CollectionItemRepository _repository;
  final RadioRepository _radioRepository;

  CollectionBloc(this._repository, this._radioRepository) : super(InitialState());

  void fetch(int collectionId) async {
    emit(LoadingState());
    final items = await _repository.getByCollection(collectionId) ?? [];

    if (items.isEmpty) {
      emit(LoadedState(const [], const []));
      return;
    }

    final stations = await _radioRepository.fetchByIds(items.map((e) => e.stationuuid).toList());
    emit(LoadedState(items, stations));
  }
}