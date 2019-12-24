import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pensamentos/screens/home/HomeBloc.dart';
import 'package:pensamentos/screens/settings/SettingsBloc.dart';
import 'package:pensamentos/services/Configuration.dart';
import 'package:pensamentos/shared/constants.dart';

class SettingsWidget extends StatefulWidget {

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {

  final SettingsBloc _settingsBloc = SettingsBloc();
  final HomeBloc _homeBloc = HomeBloc();
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _settingsBloc.initialize();
    _subscription = _homeBloc.listenerStateApp.listen((state) {
      if (state == AppLifecycleState.resumed) {
        _settingsBloc.initialize();
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    _settingsBloc.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoPageScaffold(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        SizedBox(height: 16,),
        Text('Mudar automaticamente'),
        _switch(),
        SizedBox(height: 16,),
        Divider(),
        SizedBox(height: 16,),
        _streamBuilderSlider(),
        SizedBox(height: 16,),
        Divider(),
        SizedBox(height: 16,),
        Text('Esquema de cores'),
        SizedBox(height: 16,),
        _buildSegment(),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Obs: Para mudar de pensamento basta tocar em qualquer lugar na tela "Pensamentos"',
            textAlign: TextAlign.center,
            style: TextStyle(color: Constants.color),
          ),
        ),
      ],
    );
  }

  Widget _switch() {
    return StreamBuilder<bool>(
      stream: _settingsBloc.listenerSwitch,
      initialData: false,
      builder: (context, snapshot) {
        bool value = snapshot.data ?? false;
        return CupertinoSwitch(
            activeColor: Constants.color,
            onChanged: _settingsBloc.changeSwitch,
            value: value
          );
      }
    );
  }

  Widget _streamBuilderSlider() {
    return StreamBuilder<double>(
      stream: _settingsBloc.listenerSlider,
      builder: (context, snapshot) {
        double value = snapshot.data ?? ValueConfiguration.defaultTimer;
        return _slider(value);
      }
    );
  }

  Padding _slider(double value) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Text('Mudar após ${value.toInt().toString()} segundos'),
            Row(
              children: <Widget>[
                Text(value?.toInt()?.toString()),
                Expanded(
                  child: CupertinoSlider(
                    min: 3,
                    max: 30,
                    onChangeEnd: (value) =>  _settingsBloc.changeSlider(value),
                    value: value,
                    onChanged: (double value) => _settingsBloc.changeSlider(value, updateSettings: false),
                  ),
                ),
                Text('30')
              ],
            )
          ],
        ),
      );
  }

  Widget _buildSegment() {
    return StreamBuilder<int>(
      stream: _settingsBloc.listenerSegment,
      builder: (context, snapshot) {
        int value = snapshot.data ?? 0;
        return Container(
          width: double.infinity,
          child: CupertinoSegmentedControl(
            groupValue: value,
            onValueChanged: _settingsBloc.changeSegment,
            children: const {
              0: const Text('Claro'),
              1: const Text('Escuro')
            },
          ),
        );
      }
    );
  }
}
