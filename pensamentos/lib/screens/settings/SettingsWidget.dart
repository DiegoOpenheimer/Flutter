import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pensamentos/screens/settings/SettingsBloc.dart';
import 'package:pensamentos/shared/constants.dart';

class SettingsWidget extends StatefulWidget {

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {

  final SettingsBloc _settingsBloc = SettingsBloc();

  @override
  void initState() {
    super.initState();
    _settingsBloc.initialize();
  }


  @override
  void dispose() {
    super.dispose();
    _settingsBloc.dispose();
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
    return StreamBuilder<int>(
      stream: _settingsBloc.listenerSlider,
      builder: (context, snapshot) {
        int value = snapshot.data ?? 8;
        return _slider(value);
      }
    );
  }

  Padding _slider(int value) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Text('Mudar após $value segundos'),
            Row(
              children: <Widget>[
                Text(value.toString()),
                Expanded(
                  child: CupertinoSlider(
                    min: 3,
                    max: 30,
                    onChangeEnd: (value) =>  _settingsBloc.changeSlider(value.toInt()),
                    value: value.toDouble(),
                    onChanged: (double value) => _settingsBloc.changeSlider(value.toInt(), updateSettings: false),
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
