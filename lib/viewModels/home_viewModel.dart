import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel {
  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nameData = prefs.getString('name');
    return nameData;
  }
}
