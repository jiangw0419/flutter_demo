import 'package:flutter/material.dart';
import 'package:flutter_demo/viewmodel/home/home_body_viewmodel.dart';
import 'package:flutter_demo/viewmodel/provider_widget.dart';
import 'package:flutter_demo/widget/appbar_widget.dart';
import 'package:flutter_demo/widget/banner_widget.dart';
import 'package:flutter_demo/widget/loding_widget.dart';

class HomeBodyPage extends StatefulWidget {
  @override
  _HomeBodyPageState createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WgAppBar("首页"),
      body: ProviderWidget<HomeBodyViewModel>(
        model: HomeBodyViewModel(),
        onInitModel: (model) => {model.refresh()},
        builder: (context, model, child) {
          return LoadingWidget(
            viewState: model.viewState,
            child: _banner(model),
            retry: model.retry,
          );
        },
      ),
    );
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
  bool get wantKeepAlive => true;
}
