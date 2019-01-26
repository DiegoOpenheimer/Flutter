class EntityModel {
  int hasAlert;
  String alert;
  int hasCountDown;
  int countDown;
  int minutes;
  int counterSeconds;
  int counterSecondsCountDown;
  int counterOneMinute;
  int counter; // using only in the amrapRunningBloc
  bool pause; // using only in the amrapRunningBloc

  EntityModel({
    this.hasAlert = 0,
    this.alert = 'Desligado',
    this.hasCountDown = 0,
    this.countDown = 5,
    this.minutes = 15,
    this.counterSeconds = 0,
    this.counterSecondsCountDown = 5,
    this.counterOneMinute = 0,
    this.counter = 0,
    this.pause = false,
  });

  void clearTimers() {
    this.counterSeconds = 0;
    this.counterSecondsCountDown = 5;
    this.counterOneMinute = 0;
    this.counter = 0;
    this.pause = false;
  }

  @override
  String toString() {
    return 'EntityModel{hasAlert: $hasAlert, alert: $alert, hasCountDown: $hasCountDown, countDown: $countDown, minutes: $minutes, counterSeconds: $counterSeconds, counterSecondsCountDown: $counterSecondsCountDown, counterOneMinute: $counterOneMinute, counter: $counter, pause: $pause}';
  }
}
