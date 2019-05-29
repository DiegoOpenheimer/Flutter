
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:try_bloc_pattern/BlocTheme.dart';
import 'BlocMessage.dart';
import 'dart:async';

class MessageWidget extends StatefulWidget {
  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {

  BlocMessage bloc = BlocProvider.getBloc<BlocMessage>();
  BlocTheme blocTheme = BlocProvider.getBloc<BlocTheme>();
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _controller = ScrollController();
  
  @override
  void initState() {
    super.initState();
    bloc.getMessages();
    bloc.outMessages.listen((ModelMessageWidget model) async {
      await Future.delayed(Duration.zero);
      if (_controller != null && _controller.hasClients) {
        double value = 100 + _controller.position.maxScrollExtent;
        _controller.jumpTo(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(centerTitle: true, title: Text('Messages'), actions: <Widget>[IconButton(icon: Icon(Icons.track_changes), onPressed: blocTheme.toggleTheme,)],);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBar.preferredSize.height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _body(),
          ),
        ),
      ),
      floatingActionButton: StreamBuilder(
        stream: bloc.outLoadingRequest,
        initialData: false,
        builder: (context, asyncSnapshot) => _floatingActionButton(asyncSnapshot.data),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        SizedBox(height: 16,),
        _textField(label: 'Into with message'),
        SizedBox(height: 8,),
        Expanded(
          child: _buildListenerMessages(),
        )
      ],
    );
  }

  TextField _textField({ String label = 'Field' }) {

    return TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder()
      ),
    );

  }

  StreamBuilder _buildListenerMessages() {
    return StreamBuilder<ModelMessageWidget>(
      stream: bloc.outMessages,
      initialData: ModelMessageWidget(),
      builder: (context, asyncSnapshot) {
        ModelMessageWidget model = asyncSnapshot.data;
        if (model.isLoading) {
          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(blocTheme.getCurrentTheme() == ThemeWiched.Dark ? Colors.white : Colors.black),),);
        }
        if (model.list.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.block),
                Text('Without messages')
              ],
            ),
          );
        }
        return _buildList(model.list);
      },
    );
  }

  ListView _buildList(List<Message> list) {
    return ListView.builder(
      controller: _controller,
      itemCount: list.length,
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Message message = list[index];
        return Card(
          child: Padding(padding: EdgeInsets.all(16), child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(message?.author),
                  Text(message?.content)
                ],
              ),
              Text(message?.description?.message)
            ],
          ),)
        );
      },
    );
  }
  
  FloatingActionButton _floatingActionButton(bool value) {
    return FloatingActionButton(
      onPressed: !value ? () {
        String content = _textEditingController.text;
        FocusScope.of(context).requestFocus(FocusNode());
        if (content.isEmpty) {
          content = 'Diego';
        }
        bloc.insertMessages(author: content);
        _textEditingController.text = '';
      } : () {},
      child: value ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(blocTheme.getCurrentTheme() == ThemeWiched.Dark ? Colors.black : Colors.white),),) : Icon(Icons.add)
    ); 
  }

}
