import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radiao/app/models/station_collection.dart';
import 'package:radiao/app/models/station_collection_item.dart';
import 'package:radiao/app/pages/collection/collections_state.dart';
import 'package:radiao/app/repository/collection_item_repository.dart';
import 'package:radiao/app/repository/collection_repository.dart';

class CollectionsBloc extends Cubit<CollectionsState> {
  final CollectionRepository _repository;
  final CollectionItemRepository _itemRepository;

  CollectionsBloc(this._repository, this._itemRepository) : super(InitialState());

  void fetch() async {
    emit(LoadingState());
    final collections = await _repository.getAll() ?? [];
    emit(LoadedState(collections));
  }

  void create(String collectionName) async {
    emit(LoadingState());
    await _repository.create(StationCollection(name: collectionName));
    fetch();
  }

  void delete(int collectionId) async {
    emit(LoadingState());
    await _repository.delete(collectionId);
    fetch();
  }

  void update(int collectionId, String collectionName) async {
    emit(LoadingState());
    await _repository.update(StationCollection(id: collectionId, name: collectionName));
    fetch();
  }

  void addStation(int collectionId, String stationuuid) async {
    await _itemRepository.removeStation(stationuuid);
    await _itemRepository.create(StationCollectionItem(collectionId: collectionId, stationuuid: stationuuid));
  }

  void removeStation(String stationuuid) async {
    await _itemRepository.removeStation(stationuuid);
  }
}