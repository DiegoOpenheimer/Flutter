import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_game/components/Alert.dart';
import 'package:my_game/components/CustomAppBar.dart';
import 'package:my_game/screens/game/GameController.dart';
import 'package:my_game/shared/constants.dart';
import 'package:my_game/shared/utils.dart';

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {

  final _formKey = GlobalKey<FormState>();
  final _textFieldReleaseDate = TextEditingController();
  final _gameController = GameController();

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
    _gameController.dispose();
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        autovalidate: true,
        key: _formKey,
        child: Column(
          children: <Widget>[
            _textFormField(label: "Nome do jogo", validator: _gameController.validateName),
            SizedBox(height: 8,),
            _dropdownButton(),
            SizedBox(height: 8,),
            _buildDatePicker(),
            SizedBox(height: 8,),
            Expanded(
              child: StreamBuilder<Uint8List>(
                stream: _gameController.controllerImage.stream,
                builder: (context, snapshot) {
                  return _buildContainerImage();
                }
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

  Widget _buildContainerImage() {
    var image =  _gameController.controllerImage.value;
    var widget = image != null ? Image.memory(image, fit: BoxFit.cover,) : Container();
    return Stack(
      children: <Widget>[
        Positioned.fill(child: widget),
        Center(
          child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            onPressed: () {
              Alert.showActionSheet(context, onComplete: (imageSource) async {
                if (imageSource == null) return;
                var image = await ImagePicker.pickImage(source: imageSource);
                if (image != null) {
                 _gameController.controllerImage.add(image.readAsBytesSync());
                }
              });
            },
            child: Text('Toque para adicionar uma imagem de capa', style: TextStyle(color: CustomColor.main),),
          ),
        )
      ],
    );
  }

  Widget _dropdownButton() {
    return StreamBuilder<String>(
      stream: _gameController.controllerConsole.stream,
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
            onChanged: _gameController.controllerConsole.add,
            items: _gameController.consoles
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
    return StreamBuilder<DateTime>(
      stream: _gameController.controllerReleaseDate.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _textFieldReleaseDate.text = Utils.formatterDate(snapshot.data);
        }
        return Material(
          child: InkWell(
            onTap: () => showPicker(_gameController.controllerReleaseDate.value),
            child: IgnorePointer(
              child: TextField(
                controller: _textFieldReleaseDate,
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

  void showPicker([DateTime date]) async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
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
    if (dateTime != null) {
      _gameController.controllerReleaseDate.add(dateTime);
    }
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
            cursorColor: CustomColor.main,
          );
  }
}
