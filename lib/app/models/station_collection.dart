class StationCollection {
  static const String tableName = "collections";

  final int? id;
  final String name;

  DateTime _createdAt = DateTime.now();
  DateTime get createdAt => _createdAt;

  StationCollection({
    this.id,
    required this.name,
  });

  factory StationCollection.fromMap(Map<String, dynamic> map) {
    return StationCollection(
      id: map["id"],
      name: map["name"],
    )
    .._createdAt = DateTime.fromMillisecondsSinceEpoch(map["created_at"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "created_at": _createdAt.millisecondsSinceEpoch,
    };
  }
}