import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_game/components/Alert.dart';
import 'package:my_game/components/CustomAppBar.dart';
import 'package:my_game/shared/constants.dart';
import 'package:my_game/shared/utils.dart';
import 'controller/GameController.dart';

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
              child: Observer(
                builder: (_) => _buildContainerImage()
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
    var image =  _gameController.image;
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
                 _gameController.setImage(image.readAsBytesSync());
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
    return Observer(
      builder: (_) {
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
            value: _gameController.currentConsole,
            onChanged: _gameController.setCurrentConsole,
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
    return Observer(
      builder: (_) {
        if (_gameController.releaseDate != null) {
          _textFieldReleaseDate.text = Utils.formatterDate(_gameController.releaseDate);
        }
        return Material(
          child: InkWell(
            onTap: () => Alert.showPicker(
              context,
              onComplete: _gameController.setReleaseDate,
              date: _gameController.releaseDate
            ),
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
