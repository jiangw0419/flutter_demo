
import 'package:flutter_demo/viewmodel/base_changenotify.dart';

class MainBodyViewModel extends BaseChangeNotify{
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void jumpToPage(index){
    _currentIndex = index;
    notifyListeners();
  }
}