import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class Link {
  Future launchURL({ @required String url }) async {
    assert(url != null);

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Does not possible to open linked: $url');
    }
  }
}