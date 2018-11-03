import 'package:flutter/material.dart';
import './services/moeda.service.dart';
import 'dart:async';

void main() => runApp(MaterialApp(
  title: "Conversor de moedas",
  color: Colors.amber,
  home: MyApp(),
  theme: ThemeData(
    hintColor: Colors.amber,
    primaryColor: Colors.amber
  ),
));


class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

 final TextEditingController realController = TextEditingController();
 final TextEditingController dolController = TextEditingController();
 final TextEditingController euroController = TextEditingController();
 double real;
 double dol;
 double euro;

  Widget loadingData(String message) {
    return Center(
        child: Text(message, style: TextStyle(color: Colors.amber, fontSize: 30.0),),
    );
  }

  Widget buildText(String label, String prefix, TextEditingController controller, Function callback) {
    return TextField(
      cursorColor: Colors.amber,
      style: TextStyle(color: Colors.amber, fontSize: 25.0),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix,
        prefixStyle: TextStyle(color: Colors.amber, fontSize: 25.0)
      ),
      controller: controller,
      onChanged: callback,
      keyboardType: TextInputType.number,
    );
  }

  void clearFields() {
    realController.text = "";
    dolController.text = "";
    euroController.text = "";
  }

  Function handlerTextField(String type) => (String value) {
    if (value.isEmpty) {
      clearFields();
    } else {
      try {
        switch(type) {
          case 'real':
            double real = double.parse(value);
            print((real/dol).toStringAsFixed(2));
            print(value);
            dolController.text = (real/dol).toStringAsFixed(2);
            euroController.text = (real/euro).toStringAsFixed(2);
            break;
          case 'dolar':
            double dolar = double.parse(value);
            realController.text = (dolar*this.dol).toStringAsFixed(2);
            euroController.text = (dolar*this.dol/euro).toStringAsFixed(2);
            break;
          case 'euro':
            double euro = double.parse(value);
            realController.text = (euro * this.euro).toStringAsFixed(2);
            dolController.text = ( euro * this.euro / dol ).toStringAsFixed(2);
            break;
        }

      } catch(error) {

      }
    }
  };

  Widget mainContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.monetization_on, color: Colors.amber, size: 120.0),
          buildText("Reais", "R\$", realController, handlerTextField('real')),
          Divider(),
          buildText("Dolar", "US\$", dolController, handlerTextField('dolar')),
          Divider(),
          buildText("Euro", "€", euroController, handlerTextField('euro')),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.amber,
                child: Text("Limpar", style: TextStyle(color: Colors.black)),
                onPressed: clearFields,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                padding: EdgeInsets.only(left:80.0, right: 80.0),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
          future: MoedaService().getData(),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return loadingData("Carregando informação...");
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return loadingData("Falha ao carregar dados :(");
                  } else {
                    dol = snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    return mainContent();
                  }
              }
          },
      ),
    );
  }
}