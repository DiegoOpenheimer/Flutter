import 'package:organizze_flutter/Model/Place.dart';

class Trip {

  int id;
  String name;
  double price;
  String img;
  List<Place> places = List();


  Trip({this.name, this.price, this.img});

  Trip.fromMap(Map<String, dynamic> map):
      id = map['id'],
      name = map['name'],
      img = map['img'],
      price = map['price'];


  Map<String, dynamic> toMap() => {
    'name': name,
    'img': img,
    'price': price,
  };


  String toString() => "Trip($name, $price, $places, $id, $img)";

}