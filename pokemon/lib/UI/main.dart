import 'package:flutter/material.dart';
import 'package:pokemon/UI/ItemsView.dart';
import 'package:pokemon/UI/PokemonView.dart';
import 'package:pokemon/bloc/tabBloc.dart';

import 'dart:async';

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> with SingleTickerProviderStateMixin {

  TabController _tabController;
  TabBloc _bloc;
  
  @override
  void initState() {
    super.initState();
    _bloc = TabBloc();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
        _bloc.changeTitle(_tabController.previousIndex);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: StreamBuilder<String>(
            initialData: 'Pokemons',
            stream: _bloc.stream,
            builder: (BuildContext context, AsyncSnapshot<String> snap) {
              return Text(snap.data);
            }
        ), centerTitle: true,),
        body: buildBody(context),
        bottomNavigationBar: Material(
          color: Colors.blueAccent,
          child: TabBar(
            controller: _tabController,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 45.0)),
            tabs: <Widget>[
              Tab(
                text: 'Pokemons',
              ),
              Tab(
                text: 'Items',
              )
            ],
          ),
        ),
      );
  }

  Widget buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'images/PlanoFundo.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        TabBarView(
          controller: _tabController,
          children: <Widget>[
            PokemonView(),
            ItemsView()
          ],
        )
      ],
    );
  }

}
