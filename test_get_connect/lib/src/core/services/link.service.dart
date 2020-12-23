import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class Link {
  Future<bool> launchURL({ @required String url }) async {
    assert(url != null);

    if (await canLaunch(url)) {
      return launch(url);
    } else {
      print('Does not possible to open linked: $url');
      return false;
    }
  }
}