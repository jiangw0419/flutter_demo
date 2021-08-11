import 'package:flutter/material.dart';

AppBar WgAppBar(
    String title,{
    bool showBack = false,
    List<Widget> actions,
    Color backgroundColor = Colors.white}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    brightness: Brightness.light,
    centerTitle: true,
    actions: actions,
    backgroundColor: backgroundColor,
    elevation: 0,
    leading: showBack
        ? BackButton(
            color: Colors.black,
          )
        : null,
  );
}
