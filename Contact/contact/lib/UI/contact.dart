import 'dart:io';

import 'package:contact/Helper/ContactHelper.dart';
import 'package:contact/Model/contact.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class ContactView extends StatefulWidget {

  Contact contact;

  ContactView({this.contact});

  @override
  ContactViewState createState() => ContactViewState();
}

class ContactViewState extends State<ContactView> {

  bool showLoading = false;
  ContactHelper contactHelper = ContactHelper();
  bool userEdited = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ErrorInput handlerError = ErrorInput();
  File image;

  @override
  void initState() {
    if (widget.contact != null) {
        setState(() {
          nameController.text = widget.contact.name;
          emailController.text = widget.contact.email;
          phoneController.text = widget.contact.phone;
          if ( widget.contact.image != null && widget.contact.image.isNotEmpty) {
            image = File(widget.contact.image);
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Contato'),
      ),
      body: WillPopScope(child: buildBody(context), onWillPop: () {
        if ( userEdited ) {
          mShowAlert(context);
          return new Future.value( false );
        } else {
          return new Future.value( true );
        }
      }),
      floatingActionButton: FloatingActionButton(onPressed: () {saveContact(context);},
      child: showLoading == false ? Icon(Icons.save, color: Colors.white,) :
          Container(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
      backgroundColor: Colors.red,
      )
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[ GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: image != null ?
                          FileImage(image) : AssetImage('images/person.png'),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              onTap: () {
                showModalBottom(context);
              },
            )],
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildTextInput(text: "Informe nome", textInputType: TextInputType.text, controller: nameController, errorText: handlerError.errorName, type: 'name'),
                Divider(color: Colors.white),
                buildTextInput(text: "Informe e-mail", textInputType: TextInputType.emailAddress, controller: emailController, errorText: handlerError.errorEmail, type: 'email'),
                Divider(color: Colors.white),
                buildTextInput(text: "Informe telefone", textInputType: TextInputType.phone, controller: phoneController, errorText: handlerError.errorPhone, type: 'phone'),
              ],
            ),
          )
        ],
      ),
    );
  }

  void getPicture(ImageSource type) {
    ImagePicker.pickImage(source: type)
        .then((File img) {
      if ( img != null ) {
        setState(() {
          image = img;
        });
      }
    });
  }

  Widget buildTextInput({ String text, TextInputType textInputType, TextEditingController controller, String errorText, String type }) {
    return TextField(
      decoration: InputDecoration(
        labelText: text,
        errorText: errorText
       ),
      keyboardType: textInputType,
      controller: controller,
      onChanged: (String text) {
        setState(() {
          userEdited = true;
          switch (type) {
            case 'name':
              handlerError.errorName = null;
              break;
            case 'email':
              handlerError.errorEmail = null;
              break;
            case 'phone':
              handlerError.errorPhone = null;
              break;
          }
        });
      },
    );
  }

  void saveContact(BuildContext context) {
    setState(() {
      showLoading = true;
    });
    if (validateInput(context)) {
      widget.contact.name = nameController.text;
      widget.contact.email = emailController.text;
      widget.contact.phone = phoneController.text;
      if ( image != null ) {
        widget.contact.image = image.path;
      }
      createOrEditUser(context);
    } else {
      setState(() {
        showLoading = false;
      });
    }
  }

  void createOrEditUser(BuildContext context) {
    if (widget.contact.id != null) {
      contactHelper.update(widget.contact)
          .then((int value) {
        setState(() {
          showLoading = false;
          Navigator.of(context).pop();
        });
      });
    } else {
      contactHelper.insert(widget.contact)
        .then((int value) {
            setState(() {
              showLoading = false;
              Navigator.of(context).pop(widget.contact);
            });
        });
    }
  }

  bool validateInput(BuildContext context) {
      final String message = 'Campo Obrigatório';
      bool result = true;
      setState(() {
        if (nameController.text.isEmpty) {
          handlerError.errorName = message;
          result = false;
        }

        if (emailController.text.isEmpty) {
          handlerError.errorEmail = message;
          result = false;
        }

        if (phoneController.text.isEmpty) {
          handlerError.errorPhone = message;
          result = false;
        }
        FocusScope.of(context).requestFocus(FocusNode());
      });
      return result;
  }

  void mShowAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Atenção'),
            content: Container(child: Text('Deseja salvar as configurações ?'), width: 300.0,),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.red,
                child: Text('Não', style: TextStyle(fontSize: 20.0),),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                textColor: Colors.red,
                child: Text('Sim', style: TextStyle(fontSize: 20.0),),
                onPressed: () {
                  saveContact(context);
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  void showModalBottom(BuildContext context) {
      showModalBottomSheet(context: context,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Escolha uma das opções', style: TextStyle(fontSize: 22.0),)
                    ],
                  ),
                  SizedBox(height: 30.0,),
                  InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera_alt, size: 40.0,),
                        SizedBox(width: 20.0,),
                        Text('Abrir a câmera', style: TextStyle(fontSize: 20.0),)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      Navigator.pop(context);
                      getPicture(ImageSource.camera);
                    },
                    splashColor: Colors.red[100],
                    highlightColor: Colors.red[200],
                  ),
                  SizedBox(height: 20.0,),
                  InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Row(
                      children: <Widget>[
                        Icon(Icons.photo, size: 40.0,),
                        SizedBox(width: 20.0,),
                        Text('Abrir image da galeria', style: TextStyle(fontSize: 20.0),)
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      getPicture(ImageSource.gallery);
                    },
                    splashColor: Colors.red[100],
                    highlightColor: Colors.red[200],
                  )
                ],
              ),
            );
          }
      );
  }
}

class ErrorInput {

  String _errorName;
  String _errorEmail;
  String _errorPhone;

  String get errorName => _errorName;
  String get errorEmail => _errorEmail;
  String get errorPhone => _errorPhone;

  void set errorName(String name) => _errorName = name;
  void set errorEmail(String email) => _errorEmail = email;
  void set errorPhone(String phone) => _errorPhone = phone;

}