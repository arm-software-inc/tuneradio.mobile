class Station {
  String changeuuid = "";
  String stationuuid = "";
  String name = "";
  String url = "";
  String urlResolved = "";
  String tags = "";
  String favicon = "";
  int votes = 0;
  String state = "";
  String language = "";
  String homepage = "";

  String get formattedTags => _formatTags(tags);

  Station({
    required this.changeuuid,
    required this.stationuuid,
    required this.name,
    required this.url,
    this.urlResolved = "",
    this.tags = "no tags",
    this.favicon = "",
    this.votes = 0,
    this.state = "",
    this.language = "",
    this.homepage = "",
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      changeuuid: json["changeuuid"] ?? "",
      stationuuid: json["stationuuid"] ?? "",
      name: json["name"] ?? "",
      url: json["url"] ?? "",
      urlResolved: json["url_resolved"] ?? "",
      tags: json["tags"] ?? "no tags",
      favicon: json["favicon"] ?? "",
      votes: json["votes"] ?? 0,
      state: json["state"] ?? "",
      language: json["language"],
      homepage: json["homepage"] ?? "",
    );
  }

  String _formatTags(String tags) {
    if (tags.isEmpty) return "Sem tags";

    final splitted = tags.trim().split(",");

    return splitted.length > 2 ? splitted.getRange(0, 2).join(", ") : tags;
  }
}