


import 'package:flutter_demo/http/url.dart';

class AppInit{
  AppInit._();
  static Future init() async{
    Url.baseUrl = "http://baobab.kaiyanapp.com/api/";
    Future.delayed(Duration.zero);
  }
}