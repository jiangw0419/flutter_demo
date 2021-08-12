

import 'package:flutter/material.dart';
import 'package:flutter_demo/model/common_item.dart';
import 'package:flutter_demo/state/base_list_state.dart';
import 'package:flutter_demo/viewmodel/home/home_body_viewmodel.dart';
import 'package:flutter_demo/widget/banner_widget.dart';

class HomeBodyPage extends StatefulWidget{
  @override
  _HomeBodyPageState createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends BaseListState<Item,HomeBodyViewModel,HomeBodyPage>{
  @override
  Widget getContentChild(HomeBodyViewModel model) {
    return _banner(model);
  }

  _banner(model) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      height: 200,
      child: BannerWidget(
        model: model,
      ),
    );
  }

  @override
  // TODO: implement viewModel
  HomeBodyViewModel get viewModel => HomeBodyViewModel();


}