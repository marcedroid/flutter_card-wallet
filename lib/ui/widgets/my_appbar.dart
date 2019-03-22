import 'package:flutter/material.dart';

class MyAppBar extends AppBar{
  MyAppBar({
    BuildContext context,
    String appBarTitle,
    IconData leadingIcon
  }):super(
    brightness: Brightness.light,
    elevation: 0.0,
    backgroundColor: Colors.white,
    title: Text(
      appBarTitle,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w600
      ),
    ),

    leading: IconButton(
      icon: Icon(
        leadingIcon,
        color: Colors.black,
        size: 15.0,
      ),
      onPressed: () {
        Navigator.pop(context);
      }
    )
  );
}
