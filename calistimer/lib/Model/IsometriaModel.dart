class IsometriaModel {

  int hasGoal;
  String goal;
  int seconds;
  int counterSeconds;
  int counterOneMinute;
  int counterSecondsDown;
  bool pause;

  IsometriaModel({
    this.hasGoal = 0,
    this.goal = 'Livre',
    this.seconds = 20,
    this.counterSeconds = 0,
    this.counterOneMinute = 0,
    this.counterSecondsDown = 5,
    this.pause = false,
  });

  void clearTimers() {
    counterOneMinute = 0;
    counterSeconds = 0;
    counterSecondsDown = 5;
    pause = false;
  }

}