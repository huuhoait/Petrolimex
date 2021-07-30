import 'package:uuid/uuid.dart';

class StringUtil{
  static String generateUUID(){
    var uuid = Uuid();
    String requestID = '';

    requestID = uuid.v4();
    return requestID;
  }
}