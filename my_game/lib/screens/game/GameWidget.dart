import 'package:flutter/material.dart';
import 'package:my_game/components/CustomAppBar.dart';
import 'package:my_game/screens/game/GameBloc.dart';
import 'package:my_game/shared/constants.dart';
import 'package:my_game/shared/utils.dart';

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {

  final _formKey = GlobalKey<FormState>();
  final _gameBloc = GameBloc();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: CustomAppBar('Cadastrar'),
        body: _body(),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _gameBloc.dispose();
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        autovalidate: true,
        key: _formKey,
        child: Column(
          children: <Widget>[
            _textFormField(label: "Nome do jogo", validator: _gameBloc.validateName),
            SizedBox(height: 8,),
            _dropdownButton(),
            SizedBox(height: 8,),
            _buildDatePicker(),
            SizedBox(height: 8,),
            Expanded(
              child: Container(
                color: Colors.red,
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {},
                child: Text('Registrar', style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dropdownButton() {
    return StreamBuilder<String>(
      stream: _gameBloc.controllerConsole.stream,
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: Theme.of(context).hintColor, width: 1)

          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          alignment: Alignment.center,
          child: DropdownButton(
            hint: Text('Plataforma'),
            underline: SizedBox(),
            isExpanded: true,
            value: snapshot.data,
            onChanged: _gameBloc.controllerConsole.add,
            items: _gameBloc.consoles
            .map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      }
    );
  }

  Widget _buildDatePicker() {
    return StreamBuilder<String>(
      stream: _gameBloc.controllerConsole.stream,
      builder: (context, snapshot) {
        return Material(
          child: InkWell(
            onTap: showPicker,
            child: IgnorePointer(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Lançamento',
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  suffixIcon: Icon(Icons.arrow_drop_down)
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void showPicker() async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        Color color = CustomColor.secondary;
        return Theme(
          data: ThemeData(
            primaryColor: color,
            accentColor: color,
            backgroundColor: Colors.white
          ),
          child: child,
        );
      }
    );
  }

  TextFormField _textFormField({
    String label,
    Function(String) validator
  }) {
    return TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              border: OutlineInputBorder(),
              labelText: label
            ),
            validator: validator,
          );
  }
}
