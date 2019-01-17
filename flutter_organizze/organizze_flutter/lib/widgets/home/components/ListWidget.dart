import 'package:flutter/material.dart';
import 'package:organizze_flutter/model/Movement.dart';
import 'package:organizze_flutter/widgets/home/HomeBloc.dart';
import 'package:meta/meta.dart';
import 'package:organizze_flutter/widgets/home/HomeModel.dart';

class ListWidget extends StatelessWidget {
  HomeBloc bloc;
  BuildContext context;

  ListWidget({@required this.bloc, @required this.context});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomeModel>(
      stream: bloc.stream,
      initialData: bloc.homeModel,
      builder: (BuildContext context, AsyncSnapshot<HomeModel> snapshot) {
        List<Movement> movements = snapshot.data.movements;
        if (movements.isNotEmpty) {
          return ListView.builder(
            padding: EdgeInsets.all(5),
            itemCount: movements.length,
            itemBuilder: (BuildContext context, int index) {
              return buildListTile(movements[index], index);
            },
          );
        } else if (snapshot.data.loadListMovements) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.error_outline, size: 100, color: Colors.black38,),
                Text('Lista vazia', style: TextStyle(color: Colors.black38, fontSize: 20), textAlign: TextAlign.center,)
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildListTile(Movement movement, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: buildRow(movement),
        ),
      ),
      onDismissed: (DismissDirection direction) {
        Movement movement = bloc.homeModel.movements[index];
        showAlert(index, movement);
        bloc.removeItemTemporarily(index);
      },
    );
  }

  void showAlert(int index, Movement movement) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
            width: MediaQuery.of(context).size.width * .7,
            height: 200.0,
            child: materialAlert(movement, index),
          ),
        );
      },
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation1, animation2, widget) {
        return SlideTransition(
          position: Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(animation1),
          child: widget,
        );
      },
    );
  }

  Material materialAlert(Movement movement, int index) {
    return Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              children: <Widget>[
                Text("Atenção", style: TextStyle(color: Colors.black, fontSize: 30),),
                SizedBox(height: 30,),
                Text('Deseja mesmo remover esse item?', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                Expanded(
                  child:  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                            bloc.cancelRemoveItem(index, movement);
                          },
                          child: Text('Não', style: TextStyle(fontSize: 20),),
                        ),
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                            bloc.removeItem(index, movement);
                          },
                          child: Text('Sim', style: TextStyle(fontSize: 20)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Row buildRow(Movement movement) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movement.category,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(movement.description,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16))
              ],
            ),
          ),
          Expanded(
            child: Text(
              'R\$ ' + movement.value.toStringAsFixed(2),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  color: movement.type == 'r'
                      ? Color(0xff00d39e)
                      : Color(0xffff7064),
                  fontSize: 16
                ),
            ),
          )
        ],
      );
  }
}
