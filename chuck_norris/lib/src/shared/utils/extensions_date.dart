extension CustomDateTime on DateTime {
  String get formatterDate {
    String date = "";
    date = "${this.day.toString().padLeft(2, "0")}/${this.month.toString().padLeft(2, "0")}/${this.year}";
    return date;
  }
}