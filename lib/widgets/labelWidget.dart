import 'package:flutter/material.dart';

class NewLabel extends StatelessWidget {
  const NewLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context,{String title, bool isRequire = false, FontWeight fontWeight}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0,bottom: 10.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: fontWeight,
            ),
          ),
          Text(
            isRequire ? '*' : '',
            style: TextStyle(
              color: Color(0xffeb2629),
            ),
          ),
        ],
      ),
    );
  }
}
