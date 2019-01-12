import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:organizze_flutter/components/Toast.dart';
import 'package:organizze_flutter/model/Movement.dart';
import 'package:organizze_flutter/widgets/Revenue_and_Expense/EntityBloc.dart';

class EntityWidget extends StatefulWidget {

  String operation;
  Color color;

  EntityWidget({@required this.operation}) {
    color = operation == 'revenue' ?
    Color(0xff00d39e) :
    Color(0xffff7064);
  }

  @override
  _EntityWidgetState createState() => _EntityWidgetState();

}

class _EntityWidgetState extends State<EntityWidget> {

  EntityBloc _entityBloc;
  TextEditingController _value = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  void initState() {
    super.initState();
    _entityBloc = EntityBloc();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0;
    return Theme(
      data: ThemeData(
          accentColor: widget.color,
          primaryColor: widget.color,
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          body: _buildBody(),
          floatingActionButton: showFab ? FloatingActionButton(
            onPressed: () => pressFloatActionButton(),
            child: Icon(Icons.add, color: Colors.white,),
          ) : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  void pressFloatActionButton() {
    try {
      double value = double.parse(_value.text.toString().replaceAll(',', '.'));
      String date = _date.text.toString();
      String category = _category.text.toString();
      String description = _category.text.toString();
      Movement movement = Movement(
          category,
          date,
          description,
          widget.operation == 'revenue' ? 'r' : 'e',
          value
      );
      _entityBloc.validateForm(movement);
    } on FormatException catch (e) {
      HelperToast().show('Preencha os campos corretamente', toastLong: true);
      print(e.message);
    }
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _header(),
          _body(),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .35,
      color: widget.color,
      child: textFieldHeader(),
    );
  }

  TextField textFieldHeader() {
    return TextField(
      decoration: InputDecoration(
          hintText: '00.00',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black54, fontSize: 40)
      ),
      textAlign: TextAlign.end,
      style: TextStyle(color: Colors.black54, fontSize: 40),
      controller: _value,
      keyboardType: TextInputType.number,
    );
  }

  Widget _body() {
    return new Padding(
      padding: EdgeInsets.all(16),
      child: Column(
          children: <Widget>[
            _input(label: 'Data', keyboardType: TextInputType.datetime, maxLength: 10, controller: _date),
            SizedBox(height: 30),
            _input(label: 'Categoria', maxLength: 50, controller: _category),
            SizedBox(height: 30,),
            _input(label: 'Descrição', maxLength: 50, controller: _description),
          ]
      ),
    );
  }

  Widget _input({
    String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLength,
    TextEditingController controller
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        counterText: ''
      ),
      keyboardType: keyboardType,
      maxLength: maxLength,
      cursorColor: widget.color,
      style: TextStyle(fontSize: 20, color: Colors.black),
      controller: controller,
    );
  }

  void clearAllInputs() {
    _value.text = '';
    _category.text = '';
    _date.text = '';
    _description.text = '';
  }

}