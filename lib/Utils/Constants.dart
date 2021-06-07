import 'package:flutter/material.dart';

Widget formField(String hintText) {
  return TextFormField(
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(8.0),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 16.0),
      enabledBorder: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(),
    ),
  );
}
