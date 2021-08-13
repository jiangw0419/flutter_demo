import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/app_init.dart';
import 'package:flutter_demo/main_body.dart';
import 'package:flutter_demo/utils/route_material_app_utils.dart';

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
            return GetMaterialAppWidget(
              child: MainBody(),
            );
          } else {
            return GetMaterialAppWidget(
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
