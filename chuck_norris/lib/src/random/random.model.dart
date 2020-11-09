class Random {
    Random({
        this.createdAt,
        this.iconUrl,
        this.id,
        this.updatedAt,
        this.url,
        this.value,
    });

    DateTime createdAt;
    String iconUrl;
    String id;
    DateTime updatedAt;
    String url;
    String value;

    factory Random.fromJson(Map<String, dynamic> json) => Random(
        createdAt: DateTime.parse(json["created_at"]),
        iconUrl: json["icon_url"],
        id: json["id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "icon_url": iconUrl,
        "id": id,
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
        "value": value,
    };
}