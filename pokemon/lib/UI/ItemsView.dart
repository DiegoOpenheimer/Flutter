import 'package:flutter/material.dart';
import 'package:pokemon/Models/item.dart';
import 'package:pokemon/bloc/ItemBloc.dart';
import 'package:progress_hud/progress_hud.dart';

class ItemsView extends StatefulWidget {
  @override
  _ItemsViewState createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> with AutomaticKeepAliveClientMixin<ItemsView> {


  ItemBloc itemBloc;
  ProgressHUD _progressHUD = ProgressHUD(
    backgroundColor: Colors.black26,
    loading: false,
    color: Colors.white,
  );

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    itemBloc = ItemBloc();
    itemBloc.requestServiceToGetItems();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        itemBloc.fetchingMoreItems();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
   _controller.dispose();
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
          else return Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                child: buildSuccess(itemProvider.items),
              ),
              snapshot.data.isFetchingItems ? Column(
                children: <Widget>[
                  SizedBox(height: 16,),
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(height: 16,),
                ],
              ) : null
            ].where((Widget widget) => widget != null).toList(),
          );
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
          controller: _controller,
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
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
