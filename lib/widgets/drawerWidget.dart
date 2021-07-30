import 'package:flutter/material.dart';
import 'package:petrolimex/screens/info_screen.dart';
import 'package:petrolimex/screens/sign_in_screen.dart';
import 'package:petrolimex/screens/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewDrawer extends StatelessWidget {
  bool onOff = true;
  String name;

  NewDrawer({Key key, this.onOff, this.name}) : super(key: key);

  Widget buildMenuItem(
      {String title, int color, IconData icon, VoidCallback onClicked}) {
    return ListTile(
      hoverColor: Colors.white10,
      onTap: onClicked,
      leading: Icon(
        icon,
        color: Color(color),
      ),
      title: Text(
        title,
        style: TextStyle(color: Color(0xff454f5b)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color(0xffffc20e),
        child: Column(
          children: [
            Container(
              child: SafeArea(
                minimum: EdgeInsets.only(top: 50.0, right: 115.0),
                child: Image.asset('assets/image1.png'),
              ),
            ),
            SizedBox(height: 10),
            Divider(thickness: 2),
            buildMenuItem(
                title: name??'Đăng ký PLX ID',
                color: 0xff454f5b,
                icon: Icons.person_outline,
                onClicked: () => selectedItem(context, 0)),
            buildMenuItem(
                title: 'Ưu đãi', color: 0xff454f5b, icon: Icons.card_giftcard),
            buildMenuItem(
              title: 'Quên mật khẩu',
              color: 0xff454f5b,
              icon: Icons.lock_outline,
            ),
            buildMenuItem(
                title: onOff == true ? 'Đăng nhập' : 'Đăng xuất',
                color: 0xff454f5b,
                icon: Icons.login,
                onClicked: () => selectedItem(context, 3)),
          ],
        ),
      ),
    );
  }

  selectedItem(BuildContext context, int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.of(context).pop();
    switch (i) {
      case 0:
        if(name!=null){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Info()));
        }
        else{
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SignUp()));
        }
        break;
      case 3:
        onOff = true;
        await prefs.remove('session');
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SignIn(),
          ),
              (route) => false,
        );
        break;
    }
  }


}
