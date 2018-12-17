class Place {

  int id;
  String name;
  String description;
  double price;
  double latitude;
  double longitude;
  int idTrip;

  Place({this.name, this.description, this.price, this.latitude, this.longitude});

  Place.fromMap(Map<String, dynamic> map) :
      id = map['id'],
      name = map['name'],
      description = map['description'],
      price = map['price'],
      latitude = map['latitude'],
      longitude = map['longitude'],
      idTrip = map['trip_id'];

  Map<String, dynamic> toMap() => {
    'name': name,
    'description': description,
    'price': price,
    'latitude': latitude,
    'longitude': longitude,
    'trip_id': idTrip
  };

  String toString() => 'Place($name, $description, $price, $latitude, $longitude, $id, $idTrip)';

}