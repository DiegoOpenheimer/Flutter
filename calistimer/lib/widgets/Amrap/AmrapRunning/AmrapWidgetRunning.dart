import 'package:calistimer/Model/EntityModel.dart';
import 'package:calistimer/widgets/Amrap/AmrapRunning/AmrapRunningBloc.dart';
import 'package:calistimer/widgets/Components/Title.dart';
import 'package:flutter/material.dart';
import 'package:calistimer/widgets/Components/BackgroundProgress.dart';
import 'package:calistimer/widgets/Components/Timer.dart';
import 'package:calistimer/widgets/Components/ProgressBar.dart';
import 'package:screen/screen.dart';


class AmrapRunningWidget extends StatefulWidget {

  EntityModel entityModel;
  Duration duration;

  AmrapRunningWidget(this.entityModel, {this.duration}) {assert(duration != null);}

  @override
  _AmrapRunningWidgetState createState() => _AmrapRunningWidgetState();
}


class _AmrapRunningWidgetState extends State<AmrapRunningWidget> {

  AmrapBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AmrapBloc(model: widget.entityModel);
    bloc.initialize(duration: widget.duration != null ? widget.duration : const Duration(seconds: 1));
    Screen.keepOn(true);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
    Screen.keepOn(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (bloc.getEntityModel().pause) {
          return Future.value(true);
        }
        return Future.value(false);
      },
      child: Scaffold(
        body: StreamBuilder(
            initialData: bloc.getEntityModel(),
            stream: bloc.observable,
            builder: (BuildContext context, AsyncSnapshot<EntityModel> snapshot) {
              EntityModel model = snapshot.data;
              double time = model.counterOneMinute / 60;
              return BackgroundProgress(
                value: time,
                duration: widget.duration,
                child: _body(model),
              );
          }),
      ),
    );
  }

  Widget _body(EntityModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(height: 80,),
              ComponentTitle(title: 'AMRAP',),
              SizedBox(height: 5,),
              Icon(Icons.watch_later, color: Colors.white, size: 50,),
              Expanded(
                  child: _buildStatistic(model),
              )
            ],
          ),
        ),
        _timer(model),
        Expanded(
          child: _bottom(model),
        )
      ],
    );
  }

  Widget _buildStatistic(EntityModel model) {
    int average = model.counter > 0 ? model.counterSeconds ~/ model.counter : 0;
    int result = average > 0 ? ((model.minutes * 60) / average).floor() : 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Timer(value: average,),
            Text('por repetição', style: TextStyle(color: Colors.white, fontSize: 14),)
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(result.toString(), style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Ubuntu'),),
            Text('repetições', style: TextStyle(color: Colors.white, fontSize: 14),)
          ],
        )
      ],
    );
  }

  Column _bottom(EntityModel model) {
    String value = model.counterSecondsCountDown.toString();
    Widget counter = model.hasCountDown != 0 && model.counterSecondsCountDown != 0 ? ComponentTitle(title: value, fontSizeTitle: 120,) : _buildButtonToControllerCounter(model);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: counter
        ),
        _buildBottmButtons(model),
        SizedBox(height: 20,)
      ],
    );
  }

  Widget _buildBottmButtons(EntityModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          disabledColor: Colors.white54,
          iconSize: 45,
          onPressed: model.pause ? () {
            Navigator.of(context).pop();
          } : null,
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
        ),
        RaisedButton(
          padding: EdgeInsets.all(10),
          onPressed: () {
            bloc.pause(duration: widget.duration);
          },
          shape: CircleBorder(),
          color: Colors.white54,
          child: model.pause ? Icon(Icons.play_arrow, color: Colors.white, size: 45,) : Container(
            margin: EdgeInsets.all(10),
            height: 25,
            width: 25,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ),
        IconButton(
          disabledColor: Colors.white54,
          iconSize: 45,
          color: Colors.white,
          icon: Icon(Icons.refresh),
          onPressed: model.pause ? () {
            bloc.refresh(duration: widget.duration);
          } : null,
        )
      ],
    );
  }

  Widget _buildButtonToControllerCounter(EntityModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          disabledColor: Colors.white54,
          iconSize: 45,
          color: Colors.white,
          icon: ImageIcon(AssetImage('assets/substract.png')),
          onPressed: () => bloc.handlerCounter(value: -1)
        ),
        Text(model.counter.toString(), style: TextStyle(color: Colors.white, fontSize: 120, fontFamily: 'Ubuntu')),
        IconButton(
            disabledColor: Colors.white54,
            iconSize: 45,
            color: Colors.white,
            icon:ImageIcon(AssetImage('assets/icons8-soma-480.png')),
            onPressed: () => bloc.handlerCounter(value: 1)
        )
      ],
    );
  }

  Widget _timer(EntityModel model) {
    int time = model.counterSeconds;
    int timeRest = model.minutes * 60 - model.counterSeconds;
    double progress = time / (model.minutes * 60);
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