import 'package:flutter/material.dart';
import 'package:get/get.dart';

void toPage(Widget widget, {bool opaque}) {
  Get.to(widget, opaque: opaque);
}

void back() {
  Get.back();
}

void toName(String page, {dynamic arguments}) {
  Get.toNamed(page, arguments: arguments);
}

dynamic arguments() {
  return Get.arguments;
}
