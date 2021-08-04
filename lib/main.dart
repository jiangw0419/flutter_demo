import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/app_init.dart';
import 'package:flutter_demo/main_body.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AppInit.init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
              child:MainBody(),
            );
          } else {
            return GetMaterialApp(
              child: SplashWidget(),
            );
          }
        });
  }
}

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}

class GetMaterialApp extends StatefulWidget {
  final Widget child;

  const GetMaterialApp({Key key, this.child}) : super(key: key);

  @override
  _GetMaterialApp createState() => _GetMaterialApp();
}

class _GetMaterialApp extends State<GetMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter_demo",
      initialRoute: "/",
      routes: {"/": (context) => widget.child},
    );
  }
}
