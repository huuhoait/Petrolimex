import 'dart:convert';

import 'package:crypto/crypto.dart';

class HasPassword{

  String hasPassword(String password){
    var bytes = utf8.encode(password);
    String hashedPassword = sha256.convert(bytes).toString();
    return hashedPassword;
  }
}