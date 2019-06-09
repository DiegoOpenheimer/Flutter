import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:meta/meta.dart';

class Formatter {

  static Map<String, dynamic> buildQueryParameters({ @required String apikey, @required String privateKey, int limit = 20, int offset = 0 }) {
    assert(apikey != null && privateKey != null);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String prepareHash = '$timestamp$privateKey$apikey';
    var bytes = utf8.encode(prepareHash);
    var hash = md5.convert(bytes);
    return <String, dynamic> {
      'ts': timestamp,
      'apikey': apikey,
      'hash': hash,
      'limit': limit,
      'offset': offset
    };
  }

}

