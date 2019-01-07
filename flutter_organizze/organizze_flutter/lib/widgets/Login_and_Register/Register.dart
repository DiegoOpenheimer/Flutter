import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organizze_flutter/components/Loading.dart';
import 'package:organizze_flutter/widgets/Login_and_Register/RegisterBloc.dart';
import 'package:organizze_flutter/widgets/Login_and_Register/RegisterModel.dart';
import 'package:organizze_flutter/widgets/home/HomeWidget.dart';

class RegisterWidget extends StatefulWidget {

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();

}

class _RegisterWidgetState extends State<RegisterWidget> {

  TextEditingController _textEditingControllerName = TextEditingController();
  TextEditingController _textEditingControllerEmail = TextEditingController();
  TextEditingController _textEditingControllerPassword =
      TextEditingController();
  RegisterBloc _registerBloc;
  double _heightAppBar;
  LoadingWidget _loadingWidget = LoadingWidget();

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.black.withOpacity(0.1)));
    listenBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _registerBloc.close();
  }

  void listenBloc() {
    _registerBloc.stream.listen((AuthWidgetModel registerModel) {
        if ( registerModel.isLoading ) {
          _loadingWidget.state.show();
        } else if (registerModel.accountCreate) {
          _loadingWidget.state.dismiss();
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          _loadingWidget.state.dismiss();
          showMessageError(registerModel.messageError, context);
        }
        clearFields(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.black
        ));
        return Future.value(true);
      },
      child: Stack(
        children: <Widget>[
          Theme(
            data: ThemeData(
              accentColor: Color(0xffff706a),
            ),
            child: Scaffold(
              appBar: buildAppBar(),
              body: buildBody(context),
            ),
          ),
          _loadingWidget
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    AppBar appBar = AppBar(
      backgroundColor: Color(0xff01c7d2),
      title: Text('Criar conta', style: TextStyle(color: Colors.white)),
      iconTheme: IconThemeData(color: Colors.white),
    );
    _heightAppBar = appBar.preferredSize.height;
    return appBar;
  }

  Widget buildBody(context) {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height -
          _heightAppBar -
          MediaQuery.of(context).padding.top,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Crie sua conta grátis',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            buildTextField(context, label: 'Nome', icon: Icon(Icons.person), controller: _textEditingControllerName, textCap: TextCapitalization.words),
            SizedBox(height: 16),
            buildTextField(context,
                label: 'Email',
                textInputType: TextInputType.emailAddress,
                icon: Icon(Icons.email),
                controller: _textEditingControllerEmail),
            SizedBox(height: 16),
            buildTextField(context,
                label: 'Senha', obscureText: true, icon: Icon(Icons.lock), controller: _textEditingControllerPassword),
            SizedBox(height: 30),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('CADASTRAR'),
              onPressed: () {
                String name = _textEditingControllerName.text.toString();
                String email = _textEditingControllerEmail.text.toString();
                String password = _textEditingControllerPassword.text.toString();
                _registerBloc.validateData(name, email, password);
              },
            )
          ],
        ),
      ),
    ));
  }

  Widget buildTextField(context,
      {String label,
      bool obscureText = false,
      TextInputType textInputType = TextInputType.text,
      Icon icon,
      TextEditingController controller,
      TextCapitalization textCap = TextCapitalization.none}) {
    return Theme(
      data: ThemeData(
          cursorColor: Color(0xffff706a), primaryColor: Color(0xffff706a)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon,
        ),
        style: TextStyle(fontSize: 20, color: Colors.black),
        obscureText: obscureText,
        keyboardType: textInputType,
        textCapitalization: textCap,
      ),
    );
  }

  void clearFields(context) {
    _textEditingControllerName.clear();
    _textEditingControllerEmail.clear();
    _textEditingControllerPassword.clear();
    if (context != null) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void showMessageError(String message, context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Atenção'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                onPressed: () {Navigator.pop(context);},
                child: Text('ok'),
              )
            ],
          );
        }
    );
  }
}
