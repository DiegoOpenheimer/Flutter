import 'package:contact/Helper/ContactHelper.dart';

class Contact {

  int id;
  String name;
  String email;
  String phone;
  String image;

  Contact({this.name, this.email, this.phone, this.image});

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    image = map[imageColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imageColumn: image
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() => "Contact($name, $email, $phone, $image)";

}