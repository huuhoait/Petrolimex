import 'package:flutter/material.dart';

class NewBottomNavigationBar extends StatefulWidget {
  const NewBottomNavigationBar ({Key key}) : super(key: key);

  @override
  _NewBottomNavigationBarState createState() => _NewBottomNavigationBarState();
}

class _NewBottomNavigationBarState extends State<NewBottomNavigationBar > {

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Color(0xffbe1128),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          title: Text('Ưu đãi'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_membership),
          title: Text('PLX ID'),
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}



