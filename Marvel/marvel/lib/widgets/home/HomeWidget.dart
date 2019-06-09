import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:marvel/blocs/MarvelBloc.dart';
import 'package:marvel/blocs/ThemeBloc.dart';

import 'components/ListWidget.dart';

class HomeWidget extends StatefulWidget {

  @override
  HomeStateWidget createState() => HomeStateWidget();

}

class HomeStateWidget extends State<HomeWidget> {

  ThemeBloc themeBloc;
  MarvelBloc _marvelBloc;
  double _paddingTop = 0;
  bool _dialogIsShowing = false;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    themeBloc = BlocProvider.getBloc<ThemeBloc>();
    _marvelBloc = BlocProvider.getBloc<MarvelBloc>();
    _marvelBloc.requestCharacters();
    _listenerMarvelBloc();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _marvelBloc.fetchMoreCharacters();
        _dialogIsShowing = true;
       showCupertinoDialog(
         context: context,
         builder: (context) {
           return CupertinoAlertDialog(
             content: Stack(
               children: <Widget>[
                 Padding(child: Transform.scale(scale: 2, child: CupertinoActivityIndicator(animating: true,),), padding: EdgeInsets.only(left: 16),),
                 Center(child: Text('Carregando...', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),)
               ],
             ),
           );
         }
       );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(context) {
    CupertinoNavigationBar cupertinoNavigationBar = CupertinoNavigationBar(
      middle: Text("Marvel"),
      trailing:GestureDetector(
        child: Icon(CupertinoIcons.refresh),
        onTap: themeBloc.toggleTheme,
      ),
    );
    _paddingTop = cupertinoNavigationBar.preferredSize.height + MediaQuery.of(context).padding.top;
    return CupertinoPageScaffold(
      navigationBar: cupertinoNavigationBar,
      child: _body(),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: _paddingTop,),
        Expanded(
          child: _listStreamBuilder(),
        )
      ],
    );
  }

  StreamBuilder<ModelMarvelBloc> _listStreamBuilder() {
    return StreamBuilder(
        initialData: _marvelBloc.getInitialValue,
        stream: _marvelBloc.outDataMarvel,
        builder: (context, snapshot) {
          ModelMarvelBloc model = snapshot.data;
          if (model.isFetching) {
            return Center(child: Transform.scale(child: CupertinoActivityIndicator(animating: true,), scale: 2,),);
          }
          if (model.data.results != null && model.data.results.isNotEmpty) {
            return MarvelListWidget(controller: _controller, list: model.data.results,);
          }
          if (model.message != null && model.message.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(CupertinoIcons.clear, size: 80,),
                  Text(model.message),
                  SizedBox(height: _paddingTop,)
                ],
              ),
            );
          }
          return Center(child: Text('Empty list'),);
        },
      );
  }

  void _listenerMarvelBloc() {
    _marvelBloc.outDataMarvel.listen((model) {
      if (_dialogIsShowing) {
        _dialogIsShowing = false;
        Navigator.of(context).pop();
      }
    });
  }



}

