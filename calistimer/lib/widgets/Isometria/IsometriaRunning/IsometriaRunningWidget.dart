import 'package:calistimer/Model/IsometriaModel.dart';
import 'package:calistimer/widgets/Components/BackgroundProgress.dart';
import 'package:calistimer/widgets/Components/Title.dart';
import 'package:calistimer/widgets/Isometria/IsometriaRunning/IsometriaRunningBloc.dart';
import 'package:flutter/material.dart';
import 'package:calistimer/widgets/Components/Timer.dart';

class IsometriaRunningWidget extends StatefulWidget {

  IsometriaModel isometriaModel;
  Duration duration;

  IsometriaRunningWidget(this.isometriaModel, {this.duration}) {assert(duration != null);}

  @override
  IsometriaRunningWidgetState createState() => IsometriaRunningWidgetState();
}


class IsometriaRunningWidgetState extends State<IsometriaRunningWidget> {

  IsometriaRunningBloc _isometriaRunningBloc;

  @override
  void initState() {
    super.initState();
    _isometriaRunningBloc = IsometriaRunningBloc(widget.isometriaModel);
    _isometriaRunningBloc.initialize(duration: widget.duration);
  }

  @override
  void dispose() {
    super.dispose();
    _isometriaRunningBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        IsometriaModel isometriaModel = _isometriaRunningBloc.getIsometriaModel();
        if (isometriaModel.pause) {
          return Future.value(true);
        }
        return Future.value(false);
      },
      child: Scaffold(
        body: buildStreamBuilder(),
      ),
    );

  }

  StreamBuilder<IsometriaModel> buildStreamBuilder() {
    return StreamBuilder(
        initialData: _isometriaRunningBloc.getIsometriaModel(),
        stream: _isometriaRunningBloc.observable,
        builder: (BuildContext context, AsyncSnapshot<IsometriaModel> snapshot) {
          IsometriaModel isometria = snapshot.data;
          double time = isometria.hasGoal != 0 ? isometria.counterSeconds / isometria.seconds : 0;
          return BackgroundProgress(
            value:  time < 1 ? time : 1,
            duration: widget.duration,
            child: _body(isometria),
          );
        });
  }

  Widget _body(IsometriaModel isometria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(height: 80,),
              ComponentTitle(title: 'ISOMETRIA',),
              SizedBox(height: 5,),
              Icon(Icons.watch_later, color: Colors.white, size: 50,),
            ],
          ),
        ),
        _timer(isometria),
        Expanded(
          child: _bottom(isometria),
        )
      ],
    );
  }

  Column _bottom(IsometriaModel isometria) {
    String value = isometria.counterSecondsDown.toString();
    Widget counter = isometria.counterSecondsDown != 0 ? ComponentTitle(title: value, fontSizeTitle: 120,) : Container();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: counter
        ),
        _buildBottomButtons(isometria),
        SizedBox(height: 20,)
      ],
    );
  }

  Widget _timer(IsometriaModel isometria) {
    int time = isometria.counterSeconds;
    int timeRest = isometria.seconds - isometria.counterSeconds;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Timer(value: time, fontSize: 96,),
        isometria.hasGoal != 0 ? Timer(value: timeRest > 0 ? timeRest : 0, fontSize: 20, appendText: ' restantes',) : null,
      ].where((Widget widget) => widget != null).toList(),
    );
  }

  Widget _buildBottomButtons(IsometriaModel isometria) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          onPressed: isometria.pause ? () {
            Navigator.pop(context);
          } : null,
          disabledColor: Colors.white70,
          color: Colors.white,
          iconSize: 50,
          icon: Icon(Icons.arrow_back,),
        ),
        RaisedButton(
          padding: EdgeInsets.all(10),
          onPressed: () => _isometriaRunningBloc.pause(),
          shape: CircleBorder(),
          color: Colors.white54,
          child: isometria.pause ? Icon(Icons.play_arrow, color: Colors.white, size: 45,) : Container(
            margin: EdgeInsets.all(10),
            height: 25,
            width: 25,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ),
        IconButton(
          onPressed: isometria.pause ? () {_isometriaRunningBloc.refresh(duration: widget.duration);} : null,
          disabledColor: Colors.white70,
          color: Colors.white,
          iconSize: 50,
          icon: Icon(Icons.refresh,),
        )
      ],
    );
  }

}