

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class Alert {

  static void present(context, { @required String message }) {
    assert(message != null);
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('Attention'),
          content: Center(child: Text(message)),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(_),
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }

  static void presentWithOptions(context, { @required Function callbackOK, @required String message }) {
    assert(callbackOK != null && message != null);
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('Attention'),
          content: Center(child: Text(message)),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
              isDestructiveAction: true,
            ),
            CupertinoDialogAction(
              onPressed: callbackOK,
              child: Text('Confirm'),
              isDefaultAction: true,
            ),
          ],
        );
      },
    );
  }

}