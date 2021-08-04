import 'package:flutter/material.dart';

class BaseChangeNotify with ChangeNotifier {
  var _dispose = false;

  @override
  void dispose() {
    _dispose = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    debugPrint("dispose====$_dispose");
    if (!_dispose) {
      super.notifyListeners();
    }
  }
}
