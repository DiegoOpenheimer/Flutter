import 'package:share/share.dart';

class CustomShared {
  void sharedWithImage({String title, String text}) async {
    Share.share(text, subject: title);
  }
}
