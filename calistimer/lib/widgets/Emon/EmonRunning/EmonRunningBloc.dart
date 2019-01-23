import 'dart:async';

import 'package:calistimer/Model/EmonModel.dart';
import 'package:rxdart/rxdart.dart';

class EmonRunningBloc {

  BehaviorSubject<EmonModel> _subject = BehaviorSubject(seedValue: EmonModel());

  Observable<EmonModel> stream;

  Sink<EmonModel> sink;

  StreamSubscription _observableCountDown;

  StreamSubscription _observableTimer;

  EmonRunningBloc(EmonModel emonModel) {
    _subject.value = emonModel;
    stream = _subject.stream;
    sink = _subject.sink;
  }

  void initialize({ Duration duration }) {
    EmonModel emonModel = _subject.value;
    if (emonModel.hasCountDown != 0) {
      _observableCountDown = Observable.periodic(duration).listen((data) {
        emonModel.counterSecondsCountDown--;
        _notify();
        if (emonModel.counterSecondsCountDown == 0) {
          _startTimer(duration);
          _observableCountDown.cancel();
        }
      });
    } else {
      _startTimer(duration);
    }
  }

  void _startTimer(Duration duration) {
    EmonModel emonModel = _subject.value;
    _observableTimer = Observable.periodic(duration).listen((value) {
      emonModel.counterSeconds++;
      emonModel.counterOneMinute++;
      if (emonModel.counterOneMinute == 60) {
        emonModel.counterOneMinute = 0;
      }
      if (emonModel.counterSeconds == emonModel.minutes * 60) {
        _observableTimer.cancel();
      }
      if (emonModel.hasAlert != 0 && emonModel.counterSeconds % int.tryParse(emonModel.alert.replaceAll("s", '')) == 0) {
       // TODO implement alert
      }
      _notify();
    });
  }

  void close() {
    _subject.close();
    sink.close();
    if (_observableCountDown != null) {
      _observableCountDown.cancel();
    }
    if (_observableTimer != null) {
      _observableTimer.cancel();
    }
    _subject.value.clearTimers();
  }

  void _notify() {
    if (!_subject.isClosed) {
      sink.add(_subject.value);
    }
  }

  EmonModel getEmonModel() => _subject.value;

}