import 'package:intl/intl.dart';

class Format{
  final f = new DateFormat('dd/MM/yyyy hh:mm:ss');
  final fSelectDate = new DateFormat('dd/MM/yyyy');

  split(String s){
    var result = s.replaceAll(" 00:00:00","");
    return result;
  }

}