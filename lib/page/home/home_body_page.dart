import 'package:flutter/material.dart';
import 'package:flutter_demo/config/color.dart';
import 'package:flutter_demo/model/common_item.dart';
import 'package:flutter_demo/state/base_list_state.dart';
import 'package:flutter_demo/viewmodel/home/home_body_viewmodel.dart';
import 'package:flutter_demo/widget/banner_widget.dart';
import 'package:flutter_demo/widget/list_item_widget.dart';

class HomeBodyPage extends StatefulWidget {
  @override
  _HomeBodyPageState createState() => _HomeBodyPageState();
}

const TEXT_HEADER_TYPE = 'textHeader';

class _HomeBodyPageState
    extends BaseListState<Item, HomeBodyViewModel, HomeBodyPage> {
  @override
  Widget getContentChild(HomeBodyViewModel model) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _banner(model);
          } else {
            if (TEXT_HEADER_TYPE == model.itemList[index].type) {
              return _itemTitle(model.itemList[index]);
            } else {
              return ListItemWidget(item: model.itemList[index]);
            }
          }
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Divider(
              height:
                  model.itemList[index].type == TEXT_HEADER_TYPE || index == 0
                      ? 0
                      : 0.5,
              color:
                  model.itemList[index].type == TEXT_HEADER_TYPE || index == 0
                      ? Colors.transparent
                      : Color(0xffe6e6e6),
            ),
          );
        },
        itemCount: model.itemList.length);
  }

  _itemTitle(Item item) {
    return Container(
      height: 44,
      alignment: Alignment.center,
      child: Text(
        item.data.text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: WgColor.desTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
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
  HomeBodyViewModel get viewModel => HomeBodyViewModel();
}
