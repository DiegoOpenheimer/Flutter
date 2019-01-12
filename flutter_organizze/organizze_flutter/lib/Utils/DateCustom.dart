
class DateCustom {

  static String formatterDate(DateTime dateTime) {
    return '''${dateTime.day}/${dateTime.month}/${dateTime.year}''';
  }

  static String generateKeyDateWithMonthAndYear(String date) {
    return date.split('/').sublist(1).join();
  }

}