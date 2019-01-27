import 'package:calistimer/Model/EntityModel.dart';
import 'package:calistimer/widgets/Components/Title.dart';
import 'package:calistimer/widgets/Emon/EmonRunning/EmonRunningBloc.dart';
import 'package:flutter/material.dart';
import 'package:calistimer/widgets/Components/BackgroundProgress.dart';
import 'package:calistimer/widgets/Components/Timer.dart';
import 'package:calistimer/widgets/Components/ProgressBar.dart';
import 'package:screen/screen.dart';


class EmonRunningWidget extends StatefulWidget {

  EntityModel emonModel;
  Duration duration;

  EmonRunningWidget(this.emonModel, {this.duration}) {assert(duration != null);}

  @override
  _EmonRunningWidgetState createState() => _EmonRunningWidgetState();
}


class _EmonRunningWidgetState extends State<EmonRunningWidget> {

  EmonRunningBloc _emonRunningBloc;

  @override
  void initState() {
    super.initState();
    _emonRunningBloc = EmonRunningBloc(widget.emonModel);
    _emonRunningBloc.initialize(duration: widget.duration != null ? widget.duration : const Duration(seconds: 1));
    Screen.keepOn(true);
  }

  @override
  void dispose() {
    super.dispose();
    _emonRunningBloc.close();
    Screen.keepOn(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        initialData: _emonRunningBloc.getEmonModel(),
        stream: _emonRunningBloc.stream,
        builder: (BuildContext context, AsyncSnapshot<EntityModel> snapshot) {
          EntityModel emonModel = snapshot.data;
          double time = emonModel.counterOneMinute / 60;
          return BackgroundProgress(
            value: time,
            duration: widget.duration,
            child: _body(emonModel),
          );
        }),
    );
  }

  Widget _body(EntityModel emonModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(height: 80,),
              ComponentTitle(title: 'EMON',),
              SizedBox(height: 5,),
              Icon(Icons.watch_later, color: Colors.white, size: 50,),
            ],
          ),
        ),
        _timer(emonModel),
        Expanded(
          child: _bottom(emonModel),
        )
      ],
    );
  }

  Column _bottom(EntityModel emonModel) {
    String value = emonModel.counterSecondsCountDown.toString();
    Widget counter = emonModel.hasCountDown != 0 && emonModel.counterSecondsCountDown != 0 ? ComponentTitle(title: value, fontSizeTitle: 120,) : Container();
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: counter
            ),
            RaisedButton(
              padding: EdgeInsets.all(10),
              onPressed: () {
                Navigator.pop(context);
              },
              shape: CircleBorder(),
              color: Colors.white54,
              child: Container(
                margin: EdgeInsets.all(10),
                height: 25,
                width: 25,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
            SizedBox(height: 20,)
          ],
        );
  }

  Widget _timer(EntityModel emonModel) {
    int time = emonModel.counterSeconds;
    int timeRest = emonModel.minutes * 60 - emonModel.counterSeconds;
    double progress = time / (emonModel.minutes * 60);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Timer(value: time, fontSize: 96,),
        ProgressBar(value: progress, duration: widget.duration,),
        Timer(value: timeRest, fontSize: 20, appendText: ' restantes',),
      ],
    );
  }

}