class PokemonModel {

  String _name;
  String _url;

  PokemonModel([String name, String url]) : this._name = name, this._url = url;

  PokemonModel.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    url = map['url'];
  }

  String get name => _name;

  void set name(String name) => _name = name;

  String get url => _url;

  void set url(String url) => _url = url;

  Map<String, String> toJson() => {
    'name': name,
    'url': url,
  };

  @override
  String toString() => 'Pokemon(name=$name, url=$url)';

}