class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<Character> results;

  Data({
    this.offset,
    this.limit,
    this.total,
    this.count,
    this.results,
  });

  factory Data.fromMap(Map<String, dynamic> json) => new Data(
    offset: json["offset"],
    limit: json["limit"],
    total: json["total"],
    count: json["count"],
    results: new List<Character>.from(json["results"].map((x) => Character.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "offset": offset,
    "limit": limit,
    "total": total,
    "count": count,
    "results": new List<dynamic>.from(results.map((x) => x.toMap())),
  };
}

class Character {
  int id;
  String name;
  String description;
  String modified;
  Thumbnail thumbnail;
  String resourceUri;
  Comics comics;
  Comics series;
  Stories stories;
  Comics events;
  List<Url> urls;

  Character({
    this.id,
    this.name,
    this.description,
    this.modified,
    this.thumbnail,
    this.resourceUri,
    this.comics,
    this.series,
    this.stories,
    this.events,
    this.urls,
  });

  factory Character.fromMap(Map<String, dynamic> json) => new Character(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    modified: json["modified"],
    thumbnail: Thumbnail.fromMap(json["thumbnail"]),
    resourceUri: json["resourceURI"],
    comics: Comics.fromMap(json["comics"]),
    series: Comics.fromMap(json["series"]),
    stories: Stories.fromMap(json["stories"]),
    events: Comics.fromMap(json["events"]),
    urls: new List<Url>.from(json["urls"].map((x) => Url.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "modified": modified,
    "thumbnail": thumbnail.toMap(),
    "resourceURI": resourceUri,
    "comics": comics.toMap(),
    "series": series.toMap(),
    "stories": stories.toMap(),
    "events": events.toMap(),
    "urls": new List<dynamic>.from(urls.map((x) => x.toMap())),
  };

  @override
  String toString() {
    return 'Character{id: $id, name: $name, description: $description, modified: $modified, thumbnail: $thumbnail, resourceUri: $resourceUri, comics: $comics, series: $series, stories: $stories, events: $events, urls: $urls}';
  }


}

class Comics {
  int available;
  String collectionUri;
  List<ComicsItem> items;
  int returned;

  Comics({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  factory Comics.fromMap(Map<String, dynamic> json) => new Comics(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: new List<ComicsItem>.from(json["items"].map((x) => ComicsItem.fromMap(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toMap() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": new List<dynamic>.from(items.map((x) => x.toMap())),
    "returned": returned,
  };
}

class ComicsItem {
  String resourceUri;
  String name;

  ComicsItem({
    this.resourceUri,
    this.name,
  });

  factory ComicsItem.fromMap(Map<String, dynamic> json) => new ComicsItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "resourceURI": resourceUri,
    "name": name,
  };
}

class Stories {
  int available;
  String collectionUri;
  List<StoriesItem> items;
  int returned;

  Stories({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  factory Stories.fromMap(Map<String, dynamic> json) => new Stories(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: new List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromMap(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toMap() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": new List<dynamic>.from(items.map((x) => x.toMap())),
    "returned": returned,
  };
}

class StoriesItem {
  String resourceUri;
  String name;
  ItemType type;

  StoriesItem({
    this.resourceUri,
    this.name,
    this.type,
  });

  factory StoriesItem.fromMap(Map<String, dynamic> json) => new StoriesItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
    type: itemTypeValues.map[json["type"]],
  );

  Map<String, dynamic> toMap() => {
    "resourceURI": resourceUri,
    "name": name,
    "type": itemTypeValues.reverse[type],
  };
}

enum ItemType { COVER, INTERIOR_STORY, EMPTY, PINUP }

final itemTypeValues = new EnumValues({
  "cover": ItemType.COVER,
  "": ItemType.EMPTY,
  "interiorStory": ItemType.INTERIOR_STORY,
  "pinup": ItemType.PINUP
});

class Thumbnail {
  String path;
  Extension extension;

  Thumbnail({
    this.path,
    this.extension,
  });

  factory Thumbnail.fromMap(Map<String, dynamic> json) => new Thumbnail(
    path: json["path"],
    extension: extensionValues.map[json["extension"]],
  );

  Map<String, dynamic> toMap() => {
    "path": path,
    "extension": extensionValues.reverse[extension],
  };
}

enum Extension { JPG, GIF }

final extensionValues = new EnumValues({
  "gif": Extension.GIF,
  "jpg": Extension.JPG
});

class Url {
  UrlType type;
  String url;

  Url({
    this.type,
    this.url,
  });

  factory Url.fromMap(Map<String, dynamic> json) => new Url(
    type: urlTypeValues.map[json["type"]],
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "type": urlTypeValues.reverse[type],
    "url": url,
  };
}

enum UrlType { DETAIL, WIKI, COMICLINK }

final urlTypeValues = new EnumValues({
  "comiclink": UrlType.COMICLINK,
  "detail": UrlType.DETAIL,
  "wiki": UrlType.WIKI
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
