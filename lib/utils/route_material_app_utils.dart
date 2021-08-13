import 'package:flutter/material.dart';
import 'package:flutter_demo/page/video/video_detail_page.dart';
import 'package:get/get_navigation/get_navigation.dart';

const ROUTE_HOME = "/";
const ROUTE_VIDEO_DETIAL = "/detail";

class GetMaterialAppWidget extends StatefulWidget {
  final Widget child;

  const GetMaterialAppWidget({Key key, this.child}) : super(key: key);

  @override
  _GetMaterialApp createState() => _GetMaterialApp();
}

class _GetMaterialApp extends State<GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: "flutter_demo",
    //   initialRoute: "/",
    //   routes: {"/": (context) => widget.child},
    // );

    return GetMaterialApp(
      title: "flutter_demo",
      initialRoute: "/",
      getPages: [
        GetPage(name: ROUTE_HOME, page: () => widget.child),
        GetPage(name: ROUTE_VIDEO_DETIAL, page: () => VideoDetailPage()),
      ],
    );
  }
}
