import 'package:calistimer/Model/EntityModel.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';


class AmrapBloc {

  final BehaviorSubject<EntityModel> _subject = BehaviorSubject(seedValue: EntityModel());

  Sink<EntityModel> sink;

  Observable<EntityModel> observable;

  StreamSubscription _countDownTimer;

  StreamSubscription _counterTimer;

  AmrapBloc({ EntityModel model }) {
    _subject.value = model;
    sink = _subject.sink;
    observable = _subject.stream;
  }

  void initialize({ Duration duration }) {
    EntityModel model = _subject.value;
    if (model.hasCountDown != 0) {
      _countDownTimer = Observable.periodic(duration).listen((_) {
        if (!model.pause) {
          model.counterSecondsCountDown--;
          _publish();
          if (model.counterSecondsCountDown == 0) {
            _countDownTimer.cancel();
            _startTimer(duration);
          }
        }
      });
    } else {
      _startTimer(duration);
    }
  }

  void pause({ Duration duration }) {
    EntityModel model = _subject.value;
    model.pause = !model.pause;
    if (model.counterSeconds == model.minutes * 60) {
      model.clearTimers();
      _unsubscribe();
      initialize(duration: duration);
    }
    _publish();
  }

  void refresh({ Duration duration }) {
    EntityModel model = _subject.value;
    model.clearTimers();
    model.pause = true;
    _unsubscribe();
    initialize(duration: duration);
    _publish();
  }

  void _unsubscribe() {
    if (_countDownTimer != null) {
      _countDownTimer.cancel();
    }
    if (_counterTimer != null) {
      _counterTimer.cancel();
    }
  }

  void _startTimer(Duration duration) {
    EntityModel model = _subject.value;
    _counterTimer = Observable.periodic(duration).listen((_) {
      if (!model.pause) {
        model.counterSeconds++;
        model.counterOneMinute++;
        if (model.counterOneMinute == 60) {
          model.counterOneMinute = 0;
        }
        if (model.counterSeconds == model.minutes * 60) {
          _counterTimer.cancel();
          model.pause = true;
        }
        if (model.hasAlert != 0 && model.counterSeconds % int.tryParse(model.alert.replaceAll("s", '')) == 0) {
          // TODO implement alert
        }
        _publish();
      }
    });
  }

  _publish() {
    if (!_subject.isClosed) {
      sink.add(_subject.value);
    }
  }

  void close() {
    _subject.value.clearTimers();
    sink.close();
    _subject.close();
    _unsubscribe();
  }

  void handlerCounter({ int value }) {
    EntityModel model = _subject.value;
    model.counter = model.counter + value < 0 ? 0 : model.counter + value;
    _publish();
  }

  EntityModel getEntityModel() => _subject.value;

}