import 'package:flutter/material.dart';

class NewTextField extends StatelessWidget {
  const NewTextField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context,
      {String hintText,
        String errorText,
        bool isPassword = false,
        bool isEmail = false,
        bool isPhone = false,
        TextEditingController controller,
        VoidCallback onTap,
        bool enabled = true
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        color: Colors.white,
        child: TextField(
          enabled: enabled,
          onTap: onTap,
          controller: controller,
          cursorColor: Colors.grey,
          obscureText: isPassword,
          keyboardType: isEmail
              ? TextInputType.emailAddress
              : (isPhone ? TextInputType.number : TextInputType.text),
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled == true ? Colors.white : Color(0xffEAEEF2),
            border: OutlineInputBorder(),
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            contentPadding: EdgeInsets.only(left: 10),
            errorText: errorText,
            errorStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
