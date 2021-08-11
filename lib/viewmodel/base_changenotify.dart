import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/loding_widget.dart';

class BaseChangeNotify with ChangeNotifier {
  var _dispose = false;
  ViewState viewState = ViewState.loading;

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
