import 'dart:async';

import 'package:calistimer/Model/IsometriaModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:calistimer/services/Audio.dart';

class IsometriaRunningBloc {

  AudioPlayer _audioPlayer = AudioPlayer('alert.wav', prefix: 'sounds/');

  final BehaviorSubject<IsometriaModel> _subject = BehaviorSubject(seedValue: IsometriaModel());

  Sink<IsometriaModel> sink;

  Observable<IsometriaModel> observable;

  StreamSubscription _observableCountDown;

  StreamSubscription _observableTimer;

  IsometriaRunningBloc(IsometriaModel isometriaModel) {
    _subject.value = isometriaModel;
   sink = _subject.sink;
   observable = _subject.stream;
  }

  void initialize({ Duration duration }) {
    IsometriaModel isometriaModel = _subject.value;
    _observableCountDown = Observable.periodic(duration).listen((_) {
        if (!isometriaModel.pause) {
          if (duration.inSeconds == 1) {
            _audioPlayer.play();
          }
          isometriaModel.counterSecondsDown--;
          notify();
          if (isometriaModel.counterSecondsDown == 0) {
            _startTimer(duration);
            _observableCountDown.cancel();
          }
        }
    });
  }

  void pause() {
    IsometriaModel isometria = _subject.value;
    isometria.pause = !isometria.pause;
    notify();
  }

  void _unsubscribe() {
    if (_observableCountDown != null) {
      _observableCountDown.cancel();
    }
    if (_observableTimer != null) {
      _observableTimer.cancel();
    }
  }

  void refresh({ Duration duration }) {
    _subject.value.clearTimers();
    _subject.value.pause = true;
    _unsubscribe();
    initialize(duration: duration);
    notify();
  }


  void close() {
    _audioPlayer.clear();
    _subject.value.clearTimers();
    _subject.close();
    sink.close();
    _unsubscribe();
  }

  void _startTimer(Duration duration) {
    IsometriaModel isometria = _subject.value;
    _observableTimer = Observable.periodic(duration).listen((_) {
      if (isometria.hasGoal != 0 && isometria.counterSeconds == isometria.seconds) {
        _audioPlayer.play();
      }
      if (!isometria.pause) {
        isometria.counterSeconds++;
        notify();
      }
    });
  }

  void notify() {
    if (!_subject.isClosed) {
      sink.add(_subject.value);
    }
  }

  IsometriaModel getIsometriaModel() => _subject.value;

}