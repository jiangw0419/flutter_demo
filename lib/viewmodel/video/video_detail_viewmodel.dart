import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/http/http_manager.dart';
import 'package:flutter_demo/http/url.dart';
import 'package:flutter_demo/model/common_item.dart';
import 'package:flutter_demo/utils/toast_utils.dart';
import 'package:flutter_demo/viewmodel/base_changenotify.dart';
import 'package:flutter_demo/widget/loding_widget.dart';

class VideoDetailViewModel extends BaseChangeNotify {
  List<Item> itemList = [];
  int _videoId;

  void loadVideoData(int id) {
    _videoId = id;
    HttpManager.getData(
        url: "${Url.videoRelatedUrl}$id",
        success: (json) {
          Issue issue = Issue.fromJson(json);
          itemList = issue.itemList;
          viewState = ViewState.done;
        },
        fail: (e) {
          viewState = ViewState.error;
          debugPrint("fail-error=${e.toString()}");
          WgToast.showError(e.toString());
        },
        complete: () {
          notifyListeners();
        });
  }

  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    loadVideoData(_videoId);
  }
}
