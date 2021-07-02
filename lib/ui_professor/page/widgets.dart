import 'package:flutter/material.dart';

Widget buildTextField(String labelText, String placeholder, bool isPassworder){
  return Padding(
    padding: EdgeInsets.only(bottom: 30),
    child: TextField(
      obscureText: isPassworder? true: false,
      decoration: InputDecoration(
        suffixIcon: isPassworder?
            IconButton(
              icon: Icon(Icons.remove_red_eye, color: Colors.grey,),
              onPressed: (){

              },
            ):null,
        contentPadding: EdgeInsets.only(bottom: 5),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        )
      ),
    ),
  );
}