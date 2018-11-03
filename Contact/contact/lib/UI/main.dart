import 'package:contact/Model/contact.dart';
import 'package:contact/UI/contact.dart';
import 'package:flutter/material.dart';
import 'package:contact/Helper/ContactHelper.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'dart:io';

enum OptionsPopover { orderaz, orderza }

class App extends StatefulWidget {

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {

  SearchBar searchBar;
  bool isLoading = false;
  List<Contact> contacts = List();
  List<Contact> handlerContacts = List();
  ContactHelper contactHelper = ContactHelper();

  AppState() {
    searchBar = SearchBar(
        setState: setState,
        buildDefaultAppBar: buildAppBar,
        inBar: false,
        hintText: "Buscar",
        onChanged: filterList,
        onSubmitted: (t) {},
        onClearButton: () {
          setState(() {
            this.handlerContacts = this.contacts;
          });
        }
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red,
      title: Text("Contatos", style: TextStyle(color: Colors.white),),
      centerTitle: true,
      actions: <Widget>[
        searchBar.getSearchAction(context),
        buildPopover()
      ],
    );
  }


  @override
  void initState() {
    print(double.infinity);
    super.initState();
    setState(() => isLoading = true);
    contactHelper.getContacts()
    .then((List<Contact> contacts) {
      setState(() {
        isLoading = false;
        handlerContacts = this.contacts = contacts;
      });
    })
    .catchError(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: searchBar.build(context),
        body: buildBody(),
        floatingActionButton: FloatingActionButton(onPressed: () {goPageContact(context);},
          backgroundColor: Colors.red,
          child: Icon(Icons.add, color: Colors.white,),
        ),
        resizeToAvoidBottomPadding: false,
    );
  }

  Widget buildBody() {
    if ( isLoading ) {
      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),);
    } else if ( handlerContacts.isNotEmpty ) {
      return buildListView();
    } else {
      return buildListEmpty();
    }
  }

  void filterList(String value) {
    setState(() {
      handlerContacts = contacts.where(
              (Contact contact) =>
              contact.name.toUpperCase().contains(value.toUpperCase()) ||
              contact.phone.toUpperCase().contains(value.toUpperCase()) ||
              contact.email.toUpperCase().contains(value.toUpperCase())
      ).toList();
      if ( handlerContacts.isEmpty ) {
        handlerContacts = contacts;
      }
    });
  }

  Widget buildListView() {
    return BuildList(handlerContacts, goPageContact, handlerShowDialog);
  }

  Widget buildPopover() {
    return PopupMenuButton<OptionsPopover>(
      onSelected: (OptionsPopover options) {
        switch (options) {
          case OptionsPopover.orderaz:
            setState(() {
              contacts.sort((Contact a, Contact b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
            });
            break;
          case OptionsPopover.orderza:
            setState(() {
              contacts.sort((Contact a, Contact b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
            });
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<OptionsPopover>>[
          const PopupMenuItem<OptionsPopover>(child: Text('Ordenar de A-Z'), value: OptionsPopover.orderaz,),
          const PopupMenuItem<OptionsPopover>(child: Text('Ordenar de Z-A'), value: OptionsPopover.orderza)
        ];
      },
    );
  }

  Widget buildListEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error_outline, color: Colors.red, size: 120.0,),
          Text('Lista de contatos vazia', style: TextStyle(fontSize: 22.0),)
        ],
      ),
    );
  }
  
  void goPageContact(BuildContext context, { Contact contact }) async {
    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ContactView(contact: contact ?? Contact(),)));
    List<Contact> contacts = await contactHelper.getContacts();
    setState(() {
      handlerContacts = this.contacts = contacts;
    });
  }

  void handlerShowDialog(BuildContext context, int index) {

    showDialog(context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Atenção'),
          content: Container(
            width: 300.0,
            child: Text('Deseja realmente apagar?'),
          ),
          actions: <Widget>[
            FlatButton(textColor: Colors.red, child: Text('Não', style: TextStyle(fontSize: 20.0),), onPressed: () {Navigator.of(context).pop();},),
            FlatButton(textColor: Colors.red, child: Text('Sim', style: TextStyle(fontSize: 20.0),), onPressed: () {
              contactHelper.delete(contacts[index].id);
              setState(() {
                contacts.removeAt(index);
              });
              Navigator.of(context).pop();
            },)
          ],
        );
      },
    );

  }
}

class BuildList extends StatelessWidget {

  List<Contact> contacts;
  Function callBackNavigation;
  Function showAlert;

  BuildList(this.contacts, this.callBackNavigation, this.showAlert);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: buildItem,
        cacheExtent: double.infinity,
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return GestureDetector(
      child: Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Card(
          child: Padding(padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: contacts[index].image != null ? FileImage(File(contacts[index].image)) : AssetImage('images/person.png'),
                          fit: BoxFit.cover)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildText(contacts[index].name, fontSize: 20.0, bold: FontWeight.w700),
                      buildText(contacts[index].email, fontSize: 18.0),
                      buildText(contacts[index].phone),
                    ],
                  ),
                )
              ],
            ),),
        ),),
      onTap: () {
        callBackNavigation(context, contact: contacts[index]);
      },
      onLongPress: () {
        showAlert(context, index);
      },
    );
  }

  Widget buildText(String text, {double fontSize, FontWeight bold}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize ?? 16.0, fontWeight: bold ?? FontWeight.normal),
    );
  }
}


