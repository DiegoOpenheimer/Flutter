class ItemModel {

  String _name;
  String _url;

  ItemModel([String name, String url]) :  this._name = name, this._url = url;

  ItemModel.fromMap(Map<String, dynamic> map) : this._name = map['name'], this._url = map['url'];

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }


  @override
  String toString() => 'Item(name=$name, url=$url)';

}