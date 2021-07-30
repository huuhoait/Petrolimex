import 'package:flutter/material.dart';
class NewTitle extends StatelessWidget {
  const NewTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context,{String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0,bottom: 10.0, left: 12.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xff454f5b),
          ),
        ),
      ),
    );
  }
}
