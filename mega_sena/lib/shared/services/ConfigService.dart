import 'package:rxdart/rxdart.dart';

class ConfigService {

  static final ConfigService _instance = ConfigService._internal();
  ConfigService._internal();
  factory ConfigService() => _instance;

  BehaviorSubject<String> currentTheme = BehaviorSubject.seeded('Sistema');
  String? get currentValue => currentTheme.value;


  final List<String> items = ['Sistema', 'Escuro', 'Claro'];

  void dispose() {
    currentTheme.close();
  }

}