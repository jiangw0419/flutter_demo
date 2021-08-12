import 'package:flutter/widgets.dart';
import 'package:flutter_demo/http/url.dart';
import 'package:flutter_demo/model/common_item.dart';
import 'package:flutter_demo/model/issue_model.dart';
import 'package:flutter_demo/viewmodel/home/list_body_viewmodel.dart';

class HomeBodyViewModel extends ListBodyViewModel<Item, IssueEntity> {
  List<Item> bannerList = [];

  @override
  String getUrl() => Url.feedUrl;

  @override
  void filterData(List<Item> list) {
    list.removeWhere((element) => element.type == "banner2");
  }

  @override
  void doExtraAfter() async {
    await loadMore();
  }

  @override
  IssueEntity getModel(Map<String, dynamic> json) => IssueEntity.fromJson(json);

  @override
  void getData(List<Item> list) {
    bannerList = list;
    debugPrint("bannerList=====$list");
    itemList.clear();
    //########!!!!!################
    //banner占位
    itemList.add(Item());
  }
}
