import 'dart:async';
import 'package:flutter/material.dart';
import 'package:search_gifs/UI/image.ui.dart';
import 'package:search_gifs/services/http.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:share/share.dart';

class App extends StatefulWidget {

  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> with WidgetsBindingObserver {

  List<dynamic> listGifs = new List();
  String searchGifs = '';
  int offset = 0;
  Http http = new Http();
  AppLifecycleState stateLifecycle;
  bool clicked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      stateLifecycle = state;
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new GestureDetector(
        child: new Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 24.0), child: new Row(
              children: <Widget>[
                new Expanded(child: new Image.network("https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif", fit: BoxFit.cover,))
              ],
            ),),
            new Padding(padding: EdgeInsets.all(10.0), child: new TextField(
              decoration: new InputDecoration(
                  labelText: "Nome",
                  border: new OutlineInputBorder()
              ),
              style: new TextStyle(color: Colors.white, fontSize: 22.0),
              textAlign: TextAlign.center,
              onSubmitted: (String text) {
                setState(() {
                  searchGifs = text;
                  listGifs = new List();
                });
              },
            ),),
            new Expanded(
                child: new FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch(snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return new Center(
                          child: new CircularProgressIndicator(
                            strokeWidth: 5.0,
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      case ConnectionState.none:
                       case ConnectionState.done:
                        return successConnection(context, snapshot);
                    }
                  },
                )
            )
          ].where((Widget component) => component != null).toList(),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      )
    );
  }

  Future getData() {
    if ( listGifs.length == 0 && searchGifs.isEmpty ) {
      offset = 0;
      return http.getGifs().then((dynamic data) {
          listGifs = data['data'];
      });
    } else if(searchGifs.isNotEmpty) {
      return http.searchGifs(searchGifs, offset).then((value) {
          if (clicked) {
            listGifs.addAll(value['data']);
          } else {
            listGifs = value['data'];
          }
          clicked = false;
      });
    } else {
      offset = 0;
      return new Future.value(listGifs);
    }
  }

  Widget successConnection(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return new Center(child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Icon(Icons.error_outline, color: Colors.white, size: 40.0,),
          new Text('Falha ao carregar dados'),
        ],
      ));
    } else {
      return new GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0
          ),
          itemBuilder: buildGridView,
          itemCount: listGifs.length,
      );
    }
  }

  Widget buildGridView(BuildContext context, int index) {
    Map data = listGifs[index];
    if (searchGifs.isNotEmpty && index == listGifs.length - 1) {
      return new GestureDetector(
        child: new Container(
          height: 300.0,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(Icons.add, size: 50.0, color: Colors.white,),
              new Text("Buscar", style: new TextStyle(color: Colors.white, fontSize: 20.0), textAlign: TextAlign.center,),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            offset += 20;
            clicked = true;
          });
        },
      );
    } else {
      return new GestureDetector(
        child: new FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: data['images']['fixed_height']['url'],
          fit: BoxFit.cover,
          height: 300.0,
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => new ImageView(gif: data)
          ));
        },
        onLongPress: () {
          Share.share(data['images']['fixed_height']['url']);
        },
      );
    }
  }
}