import 'dart:io';

class NewTripModel {

  bool _errorInput = false;
  String _message;
  File _image;
  bool _goBackPage = false;

  bool get goBackPage => _goBackPage;

  void set goBackPage(bool value) => _goBackPage = value;

  bool get errorInput => _errorInput;

  set errorInput(bool value) {
    _errorInput = value;
  }

  String get message => _message;

  File get image => _image;

  set image(File value) {
    _image = value;
  }

  set message(String value) {
    _message = value;
  }

  @override
  String toString() {
    return 'NewTripModel{_errorInput: $_errorInput, _message: $_message, _image: $_image}';
  }


}