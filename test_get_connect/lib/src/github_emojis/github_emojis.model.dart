class Emojis {

  String name;
  String url;

  Emojis({this.name, this.url});

  factory Emojis.fromJson(Map<String, dynamic> value) => Emojis(
    name: value['name'],
    url: value['url']
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'url': url,
  };

}