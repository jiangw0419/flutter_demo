import 'package:flutter/material.dart';
import 'package:flutter_demo/model/common_item.dart';
import 'package:flutter_demo/utils/navigator_utils.dart';
import 'package:flutter_demo/widget/appbar_widget.dart';

const VIDEO_SMALL_CARD_TYPE = 'videoSmallCard';

class VideoDetailPage extends StatefulWidget {
  final Data videoData;

  const VideoDetailPage({Key key, this.videoData}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  Data data;

  @override
  void initState() {
    super.initState();
    data = arguments() == null ? widget.videoData : arguments();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("<><><><><>${arguments()}");
    return Scaffold(
      appBar: WgAppBar("详情"),
      body: Container(
        color: Colors.white54,
      ),
    );
  }
}
