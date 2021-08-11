import 'package:flutter/material.dart';
import 'package:flutter_demo/http/http_manager.dart';
import 'package:flutter_demo/http/url.dart';
import 'package:flutter_demo/model/common_item.dart';
import 'package:flutter_demo/model/issue_model.dart';
import 'package:flutter_demo/utils/toast_utils.dart';
import 'package:flutter_demo/viewmodel/base_changenotify.dart';
import 'package:flutter_demo/viewmodel/home/list_body_viewmodel.dart';
import 'package:flutter_demo/widget/loding_widget.dart';

class HomeBodyViewModel extends BaseChangeNotify {
// class HomeBodyViewModel extends ListBodyViewModel<Item,HomeBodyViewModel> {
//
//   @override
//   String getUrl() => Url.feedUrl;
//
//   @override
//   void filterData(List<Item> t) {
//     itemList.removeWhere((element) => element.type == "banner2");
//   }
//
//   @override
//   void doExtraAfter() {
//
//   }
  List<Item> bannerList = [];

  void refresh() {
    HttpManager.getData(
        url: Url.feedUrl,
        success: (json) {
          var issue = IssueEntity.fromJson(json);
          bannerList = issue.itemList;
          debugPrint("bannerList=$bannerList");
          bannerList.removeWhere((element) => element.type == "banner2");
          viewState = ViewState.done;
        },
        fail: (e) => WgToast.showError(e.toString()),
        complete: () => notifyListeners());
  }

  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }
}
