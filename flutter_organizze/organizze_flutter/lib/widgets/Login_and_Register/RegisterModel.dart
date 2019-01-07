class AuthWidgetModel {

  bool _isLoading;
  bool _accountCreate = false;

  bool get accountCreate => _accountCreate;

  set accountCreate(bool value) {
    _accountCreate = value;
  }

  String _messageError;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  String get messageError => _messageError;

  set messageError(String value) {
    _messageError = value;
  }

  @override
  String toString() {
    return 'RegisterModel{_isLoading: $_isLoading, _accountCreate: $_accountCreate, _messageError: $_messageError}';
  }

}