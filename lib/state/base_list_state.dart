import 'package:flutter/material.dart';
import 'package:flutter_demo/model/page_model.dart';
import 'package:flutter_demo/viewmodel/home/list_body_viewmodel.dart';
import 'package:flutter_demo/viewmodel/provider_widget.dart';
import 'package:flutter_demo/widget/loding_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListState<T, M extends ListBodyViewModel<T, PagingModel<T>>,
        P extends StatefulWidget> extends State<P>
    with AutomaticKeepAliveClientMixin {
  M get viewModel; //真实获取数据的仓库

  Widget getContentChild(M model); //真实的分页控件

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<M>(
      model: viewModel,
      onInitModel: (model) => model.refresh(),
      builder: (context, model, child) {
        return LoadingWidget(
          viewState: model.viewState,
          retry: model.retry,
          child: SmartRefresher(
            controller: model.refreshController,
            child: getContentChild(model),
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
