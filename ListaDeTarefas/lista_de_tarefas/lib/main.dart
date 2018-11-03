import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MaterialApp(
  color: Colors.blueAccent,
  title: "Lista de tarefas",
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}


class MyAppState extends State<MyApp> {

  TextEditingController input = TextEditingController();
  List listTask = [];
  int indexRemoved;
  Map taskRemoved;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    initializeList();
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      child: CheckboxListTile(
        value: listTask[index]["ok"],
        onChanged: (bool value) {
          setState(() {
            listTask[index]["ok"] = value;
            saveData();
          });
        },
        secondary: CircleAvatar(
          child: listTask[index]["ok"] ? Icon(Icons.check, color: Colors.white,) : Icon(Icons.error, color: Colors.white,),
        ),
        title: Text(listTask[index]["title"]),
      ),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white,),
        ),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
          taskRemoved = Map.from(listTask[index]);
          indexRemoved = index;
          setState(() {
            listTask.removeAt(index);
            saveData();
          });
          showSnackBar(taskRemoved["title"], context);
      },
    );
  }

  void showSnackBar(String name, BuildContext context) {
    SnackBar snackBar = SnackBar(
        content: Text("Tarefa $name removida"),
        action: SnackBarAction(
          label: "Cancelar",
          onPressed: () {
            setState(() {
              listTask.insert(indexRemoved, taskRemoved);
              saveData();
            });
          },
        ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void addItem() {
    Map task = Map();
    if (input.text.isEmpty) {
      showLongToast();
    } else {
      task["title"] = input.text;
      task["ok"] = false;
      setState(() {
        listTask.add( task );
        saveData();
      });
    }
    input.text="";
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void showLongToast() {
    Fluttertoast.showToast(
      msg: "Preencha os campos",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 3
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Lista de tarefas"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    cursorColor: Colors.blueAccent,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 22.0),
                    decoration: InputDecoration(
                        labelText: "Informe tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent)
                    ),
                    controller: input,
                  ),
                ),
                RaisedButton(
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: addItem,
                  color: Colors.blueAccent,
                )
              ],
            ),
          ),
          Container(
            child: Expanded(
                child: RefreshIndicator(
                  child: ListView.builder(
                    itemCount: listTask.length,
                    itemBuilder: buildItem,
                  ),
                  onRefresh: () async {
                    setState(() {
                      listTask.sort((a, b) {
                          if(a["ok"] && !b["ok"]) return 1;
                          else if(!a["ok"] && b["ok"]) return -1;
                          else return 0;
                      });
                    });
                    return Future((){});
                  },
                )
            ),
          )
        ],
      ),
    );
  }

  Future initializeList() async {
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        listTask = json.decode(sharedPreferences.getString('task')) ?? [];
      });
  }

  Future saveData() {
    return sharedPreferences.setString('task', json.encode(listTask));
  }


}
