import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context, {TextEditingController controller, VoidCallback onEditingComplete, TextInputAction textInputAction}) {
    return Container(
      width: 50.0,
      child: TextField(
        keyboardType: TextInputType.number,
        cursorColor: Colors.grey,
        controller:  controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.grey)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        style: TextStyle(
          fontSize: 15.0,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        onEditingComplete: onEditingComplete,
        textInputAction: textInputAction,
      ),
    );
  }
}
