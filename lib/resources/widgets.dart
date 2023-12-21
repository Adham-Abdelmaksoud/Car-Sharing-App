import 'package:flutter/material.dart';

import 'colors.dart';

Widget LoginSignupTextField({
  TextEditingController? controller,
  String? Function(String?)? validator,
  String? hintText,
  TextInputType? keyboardType,
  bool obscureText=false,
}){
  return SizedBox(
    height: 60,
    child: TextFormField(
      cursorHeight: 20,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal
          )
      ),
      style: TextStyle(
          fontSize: 18,
          height: 1
      ),
    ),
  );
}


Widget PaymentRadioButton({
  required String value,
  required String groupValue,
  required void Function(String?) onChanged}
){
  return Row(
    children: [
      Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged
      ),
      Text(value,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
      ),
    ],
  );
}


Widget AvailableRoutesSearchbar({
  String? hintText,
  Widget? icon,
  void Function(String)? onChanged
}){
  return TextField(
    cursorColor: secondaryColor,
    onChanged: onChanged,
    decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: secondaryColor
            )
        ),
        iconColor: secondaryColor
    ),
  );
}


void ShowSnackBar(BuildContext context, String message, int millisecondDuration, Color color){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: millisecondDuration),
      backgroundColor: color,
      content: Text(message,
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
    )
  );
}