import 'package:flutter/material.dart';
import 'package:pokemon/Models/item.dart';
import 'package:pokemon/bloc/ItemBloc.dart';
import 'package:progress_hud/progress_hud.dart';
import 'dart:async';

class ItemsView extends StatefulWidget {
  @override
  _ItemsViewState createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> with AutomaticKeepAliveClientMixin<ItemsView> {

  ItemBloc itemBloc = ItemBloc();
  ProgressHUD _progressHUD = ProgressHUD(
    backgroundColor: Colors.black26,
    loading: false,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    itemBloc.requestServiceToGetItems();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildStream(context),
        _progressHUD
      ],
    );
  }
  
  Widget buildStream(BuildContext context) {
    return StreamBuilder<ItemProvider>(
      stream: itemBloc.streamItem,
      builder: (BuildContext context, AsyncSnapshot<ItemProvider> snapshot) {
        if (snapshot.hasError) {
          return buildError();
        } else if (!snapshot.hasData) {
          return loadingView();
        } else {
          ItemProvider itemProvider = snapshot.data;
          if (itemProvider.hasError) return buildError();
          else return buildSuccess(itemProvider.items);
        }
      },
    );
  }
  
  Widget loadingView() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
  
  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, size: 50.0, color: Colors.white,),
          SizedBox(height: 10.0,),
          Text('Erro, verifique conexão com a internet', style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
  
  Widget buildSuccess(List<ItemModel> items) {
    return Scrollbar(
      child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/${items[index].name}.png',),
                  Text(items[index].name, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)
                ],
              ),
              onTap: () {
              },
            );
          }
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
