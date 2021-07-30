import 'package:flutter/material.dart';

class NewFloatingActionButton extends StatelessWidget {
  const NewFloatingActionButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.location_on_outlined,
        color: Color(0xff454f5b),
      ),
      onPressed: (){},
      backgroundColor: Color(0xffffc20e),
    );
  }
}
