import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_game/components/CustomAppBar.dart';
import 'package:my_game/components/CustomDismissable.dart';
import 'package:my_game/model/ConsoleProvider.dart';
import 'package:my_game/screens/consoles/controller/ConsolesController.dart';
import 'package:my_game/shared/constants.dart';
import 'package:my_game/components/Alert.dart';

class ConsolesWidget extends StatelessWidget {

  final ConsolesController _consolesController = ConsolesController();

  ConsolesWidget() {
    _consolesController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        'Plataformas',
        color: CustomColor.secondary,
        actions: <Widget>[
          IconButton(
            onPressed: () => _registerConsole(context),
            icon: Icon(Icons.add),
            color: Colors.white,
          )
        ],
      ),
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Observer(
      builder: (_) {
        if (_consolesController.consoles.isNotEmpty) {
          return ListView.separated(
            separatorBuilder: (c, i) => Divider(height: 1,),
            itemCount: _consolesController.consoles.length,
            itemBuilder: (_, int index) => _item(_consolesController.consoles[index]),
          );
        }
        return Center(
          child: Text('Nenhuma plataforma cadastrada', style: TextStyle(fontSize: 20),),
        );
      }
    );
  }

  Widget _item(Console console) {
    return CustomDismissable(
      id: console.id.toString(),
      onDismiss: (_) async {
        await _consolesController.removeConsole(console);
      },
      child: ListTile(
        title: Text(console.name),
      ),
    );
  }

  void _registerConsole(context) {
    Alert.showInputAlert(
      context,
      title: 'Cadastrar plataforma',
      label: 'Nome',
      onComplete: _consolesController.createConsole
    );
  }

}
