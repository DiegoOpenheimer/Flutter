class EmonModel {

  int hasAlert;
  String alert;
  int hasCountDown;
  int countDown;
  int minutes;
  int counterSeconds;
  int counterSecondsCountDown;
  int counterOneMinute;

  EmonModel({
    this.hasAlert = 0,
    this.alert = 'Desligado',
    this.hasCountDown = 0,
    this.countDown = 5,
    this.minutes = 15,
    this.counterSeconds = 0,
    this.counterSecondsCountDown = 5,
    this.counterOneMinute = 0,
  });


  @override
  String toString() {
    return 'EmonModel{hasAlert: $hasAlert, alert: $alert, hasCountDown: $hasCountDown, countDown: $countDown, minutes: $minutes, counterSeconds: $counterSeconds, counterSecondsCountDown: $counterSecondsCountDown, counterOneMinute: $counterOneMinute}';
  }

  void clearTimers() {
    this.counterSeconds = 0;
    this.counterSecondsCountDown = 5;
    this.counterOneMinute = 0;
  }

}