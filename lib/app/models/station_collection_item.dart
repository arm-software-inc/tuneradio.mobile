class StationCollectionItem {
  static const String tableName = "collections_items";

  int? id;
  int collectionId;
  String stationuuid;
  
  DateTime _createdAt = DateTime.now();
  DateTime get createdAt => _createdAt;

  StationCollectionItem({
    this.id,
    required this.collectionId,
    required this.stationuuid,
  });

  factory StationCollectionItem.fromMap(Map<String, dynamic> map) {
    return StationCollectionItem(
      id: map["id"],
      collectionId: map["collection_id"],
      stationuuid: map["stationuuid"],
    ).._createdAt = DateTime.fromMillisecondsSinceEpoch(map["created_at"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "collection_id": collectionId,
      "stationuuid": stationuuid,
      "created_at": _createdAt.millisecondsSinceEpoch,
    };
  }
}