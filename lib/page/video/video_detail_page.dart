import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/http/cache_network_image_provider.dart';
import 'package:flutter_demo/model/common_item.dart';
import 'package:flutter_demo/utils/navigator_utils.dart';
import 'package:flutter_demo/viewmodel/provider_widget.dart';
import 'package:flutter_demo/viewmodel/video/video_detail_viewmodel.dart';
import 'package:flutter_demo/widget/loding_widget.dart';
import 'package:flutter_demo/widget/video/video_detail_list_item_widget.dart';
import 'package:flutter_demo/widget/video/video_player_widget.dart';

const VIDEO_SMALL_CARD_TYPE = 'videoSmallCard';

class VideoDetailPage extends StatefulWidget {
  final Data videoData;

  const VideoDetailPage({Key key, this.videoData}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
 with WidgetsBindingObserver{
  Data data;
  // 允许element在树周围移动(改变父节点), 而不会丢失状态
  final GlobalKey<VideoPlayerWidgetState> videoKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    data = arguments() == null ? widget.videoData : arguments();
    WidgetsBinding.instance.addObserver(this);

  }
  @override
  void dispose() {
    //移除监听页面可见与不可见状态
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

 @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
   //AppLifecycleState当前页面的状态(是否可见)
   if (state == AppLifecycleState.paused) {
     // 页面不可见时,暂停视频
     // videoKey.currentState：树中当前具有此全局密钥的小部件的State对象
     videoKey.currentState.pause();
   } else if (state == AppLifecycleState.resumed) {
     videoKey.currentState.play();
   }
    // super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<VideoDetailViewModel>(
        model: VideoDetailViewModel(),
        onInitModel: (model) => model.loadVideoData(data.id),
        builder: (context, model, child) {
          return _videoWidget(model);
        },
      ),
    );
  }

  _videoWidget(model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///状态栏，
        AnnotatedRegion(
            child: Container(
              color: Colors.black,
              height: MediaQuery.of(context).padding.top,
            ),
            value: SystemUiOverlayStyle.light),

        ///视频播放器
        VideoPlayerWidget(key: videoKey,playUrl: data.playUrl,),
        ///视频播放器底部描述信息
        _videoTextInfo(model),
      ],
    );
  }

  _videoTextInfo(model) {
    return Expanded(
        flex: 1,
        child: LoadingWidget(
          viewState: model.viewState,
          retry: model.retry,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: cacheNetworkImage(
                      // "${data.cover.blurred}")),
                      "${data.cover.blurred}}/thumbnail/${MediaQuery.of(context).size.height}x${MediaQuery.of(context).size.width}")),
              // "${data.cover.blurred}")),
            ),
            child: CustomScrollView(
              slivers: [
                _sliverToBoxAdapter(),
                _sliverChildBuilderDelegate(model),
              ],
            ),
          ),
        ));
  }

  _sliverChildBuilderDelegate(VideoDetailViewModel model) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (model.itemList[index].type == VIDEO_SMALL_CARD_TYPE) {
          //列表页面
          return VideoDetailListItemWidget(
            item: model.itemList[index],
          );
        } else {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              model.itemList[index].data.text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          );
        }
      }, childCount: model.itemList.length),
    );
  }

  ///标题、简介、
  _sliverToBoxAdapter() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _videoTitle(),
            _videoDesc(),
            _videoCounts(),
          ],
        ),
      ),
    );
  }

  _videoTitle() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Text(
        data.title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  _videoDesc() {
    return Padding(
      padding: EdgeInsets.only(top: 1),
      child: Text(
        data.description,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  _videoCounts() {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          _row("images/ic_like.png",
              data.consumption.collectionCount.toString()),
          Padding(padding: EdgeInsets.only(left: 15)),
          _row("images/icon_comment.png",
              data.consumption.realCollectionCount.toString()),
          Padding(padding: EdgeInsets.only(left: 15)),
          _row("images/ic_share_white.png",
              data.consumption.shareCount.toString()),
        ],
      ),
    );
  }

  _row(String image, String counts) {
    return Row(
      children: [
        Image.asset(
          image,
          width: 22,
          height: 22,
        ),
        Text(
          counts,
          style: TextStyle(color: Colors.white, fontSize: 12),
        )
      ],
    );
  }
}
