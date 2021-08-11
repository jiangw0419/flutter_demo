import 'package:flutter_demo/http/http_manager.dart';
import 'package:flutter_demo/model/page_model.dart';
import 'package:flutter_demo/utils/toast_utils.dart';
import 'package:flutter_demo/viewmodel/base_changenotify.dart';
import 'package:flutter_demo/widget/loding_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class ListBodyViewModel<T, M extends PagingModel<T>>
    extends BaseChangeNotify {
  List<T> itemList = [];
  String nextPageUrl;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //请求返回的真实数据模型
  M getModel(Map<String, dynamic> json);

  void refresh() {
    HttpManager.getData(
        url: getUrl(),
        success: (json) {
          M model = getModel(json); //
          filterData(model.itemList);
          getData(model.itemList);
          viewState = ViewState.done;

          //下一页数据
          nextPageUrl = getNextUrl(model);
          _refreshController.refreshCompleted();
          _refreshController.footerMode.value = LoadStatus.canLoading;
          //额外操作
          doExtraAfter();
        },
        fail: (e) {
          WgToast.showError(e.toString());
          viewState = ViewState.error;
          _refreshController.refreshFailed();
        },
        complete: () => notifyListeners());
  }

  Future<void> loadMore() async {
    if (nextPageUrl == null) {
      _refreshController.loadNoData();
      return;
    }
    HttpManager.getData(
        url: nextPageUrl,
        success: (json) {
          M model = getModel(json);
          filterData(model.itemList);
          itemList.addAll(model.itemList);
          nextPageUrl = getNextUrl(model);
          _refreshController.refreshCompleted();
          notifyListeners();
        },
        fail: (e) {
          WgToast.showError(e.toString());
          viewState = ViewState.error;
          _refreshController.refreshFailed();
        },
        complete: () => notifyListeners());
  }

  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }

  // 获取数据
  void getData(List<T> list) {
    this.itemList = list;
  }

  //上拉加载更多请求地址
  String getNextUrl(M model) {
    return model.nextPageUrl;
  }

  String getUrl();

  List<T> parserData(json);

  void filterData(List<T> t);

  void doExtraAfter();
}
