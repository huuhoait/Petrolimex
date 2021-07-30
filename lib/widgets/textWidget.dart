import 'package:flutter/material.dart';

class NewText extends StatelessWidget {
  const NewText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, {String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 12.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w300,
            color: Color(0xff454f5b),
          ),
        ),
      ),
    );
  }
}
