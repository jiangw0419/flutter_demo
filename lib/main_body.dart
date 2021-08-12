import 'package:flutter/material.dart';
import 'package:flutter_demo/config/color.dart';
import 'package:flutter_demo/config/string.dart';
import 'package:flutter_demo/page/home/home_page.dart';
import 'package:flutter_demo/utils/toast_utils.dart';
import 'package:flutter_demo/viewmodel/main_body_viewmodel.dart';
import 'package:flutter_demo/viewmodel/provider_widget.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  DateTime _lastDateTime;

  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body:ProviderWidget<MainBodyViewModel>(
          model: MainBodyViewModel(),
          builder: (context,model,child){
            debugPrint("body-child=$child----model=${model.currentIndex}----context=$context");
            return PageView(
              physics: NeverScrollableScrollPhysics(),
              children: _children(),
              controller: _controller,
              // onPageChanged: (index){
              //   if(model.currentIndex != index){
              //     model.jumpToPage(index);
              //     setState(() {
              //     });
              //   }
              // },
            );
          },
        ),
        bottomNavigationBar: ProviderWidget<MainBodyViewModel>(
          model: MainBodyViewModel(),
          builder: (context, model, child) {
            debugPrint("bottomNavigationBar-child=$child----model=${model.currentIndex}----context=$context");
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: _items(),
              selectedItemColor: WgColor.desTextColor,
              unselectedItemColor: WgColor.hitTextColor,
              currentIndex: _getCurrentIndex(model),
              onTap: (index) {
                if (index != model.currentIndex) {
                  model.jumpToPage(index);
                  _controller.jumpToPage(model.currentIndex);
                }
              },
            );
          },
        ),
      ),
    );
  }

  _getCurrentIndex(MainBodyViewModel model) {
    debugPrint("modelindex=${model.currentIndex}");
    return model.currentIndex;
  }

  List<Widget> _children() {
    return [
      HomePage(),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.purple,
      ),
    ];
  }

  List<BottomNavigationBarItem> _items() {
    return [
      _barItem(WgString.home, "images/ic_home_normal.png",
          "images/ic_home_selected.png"),
      _barItem(WgString.discovery, "images/ic_discovery_normal.png",
          "images/ic_discovery_selected.png"),
      _barItem(WgString.hot, "images/ic_hot_normal.png",
          "images/ic_hot_selected.png"),
      _barItem(WgString.mine, "images/ic_mine_normal.png",
          "images/ic_mine_selected.png"),
    ];
  }

  BottomNavigationBarItem _barItem(
      String title, String normalIcon, String selectedIcon) {
    return BottomNavigationBarItem(
        label: title,
        icon: Image.asset(
          normalIcon,
          width: 24,
          height: 24,
        ),
        activeIcon: Image.asset(
          selectedIcon,
          width: 24,
          height: 24,
        ));
  }

  Future<bool> _onWillPop() async {
    if (_lastDateTime == null ||
        DateTime.now().difference(_lastDateTime) > Duration(seconds: 2)) {
      _lastDateTime = DateTime.now();
      WgToast.showTip("再按一次退出App");
      return false;
    } else {
      return true;
    }
  }
}
