

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_game/shared/constants.dart';

abstract class Alert {

  static void showActionSheet(context, { Function(ImageSource) onComplete }) {
    showModalBottomSheet(context: context, builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                onTap: () {
                  onComplete(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.camera),
                title: Text('Camera'),
              ),
              SizedBox(height: 8,),
              ListTile(
                onTap: () {
                  onComplete(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.photo_library),
                title: Text('Biblioteca de fotos'),
              ),
              SizedBox(height: 8,),
              FlatButton(
                onPressed: Navigator.of(context).pop,
                child: Text('Cancelar', style: TextStyle(color: Colors.red, fontSize: 18), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 8,),
            ],
          ),
        ],
      );
    });
  }

  static void showPicker(context, { @required Function(DateTime) onComplete, DateTime date }) async {
    assert(onComplete != null);
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
      onComplete(dateTime);
    }
  }

  static void showInputAlert(
      context, {
        @required Function(String) onComplete,
        String title = "Atenção",
        String label = 'Campo'
      }
    ) {
    assert(onComplete != null);
    TextEditingController controller = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Text(title),
          content: Theme(
            data: ThemeData(
              primaryColor: CustomColor.secondary
            ),
            child: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                labelText: label,
              ),
              cursorColor: CustomColor.secondary,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar', style: TextStyle(color: CustomColor.secondary, fontWeight: FontWeight.w900),),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Salvar', style: TextStyle(color: CustomColor.secondary),),
              onPressed: () {
                onComplete(controller.text);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

}