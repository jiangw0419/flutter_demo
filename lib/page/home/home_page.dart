import 'package:flutter/material.dart';
import 'package:flutter_demo/config/string.dart';
import 'package:flutter_demo/page/home/home_body_page.dart';
import 'package:flutter_demo/widget/appbar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeBodyPageState createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WgAppBar(WgString.home),
      body: HomeBodyPage(),
    );
  }
}
