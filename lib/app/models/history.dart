class History {
  static const String tableName = "history";
  
  final int? id;
  final String value;

  DateTime get createdAt => _createdAt;
  DateTime _createdAt = DateTime.now();

  History({this.id, required this.value});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "value": value,
      "created_at": _createdAt.millisecondsSinceEpoch,
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map["id"], 
      value: map["value"],
    ).._createdAt = DateTime.fromMillisecondsSinceEpoch(map["created_at"]);
  }
}