import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {

  _LoadingWidgetState state;

  @override
  _LoadingWidgetState createState() {
    state =  _LoadingWidgetState();
    return state;
  }
}

class _LoadingWidgetState extends State<LoadingWidget> {

  bool _showLoading = false;

  @override
  Widget build(BuildContext context) {
    return _showLoading ? Container(
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    ) : Container();
  }

  void show() {
    setState(() {
      _showLoading = true;
    });
  }

  void dismiss() {
    setState(() {
      _showLoading = false;
    });
  }
}
