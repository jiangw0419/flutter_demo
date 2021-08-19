import 'package:flutter/material.dart';
import 'package:flutter_demo/http/cache_network_image_provider.dart';
import 'package:flutter_demo/model/common_item.dart';
import 'package:flutter_demo/utils/date_format_utils.dart';

class VideoDetailListItemWidget extends StatefulWidget {
  final Item item;

  const VideoDetailListItemWidget({Key key, this.item}) : super(key: key);

  @override
  _VideoDetailListItemWidgetState createState() =>
      _VideoDetailListItemWidgetState();
}

class _VideoDetailListItemWidgetState extends State<VideoDetailListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Row(
        children: [
          _itemCover(),
          _itemDesc(),
        ],
      ),
    );
  }

  Widget _itemCover() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: cacheNetworkImageProvider(widget.item.data.cover.feed,
              width: 135, height: 80),
        ),
        Positioned(
          right: 5,
          bottom: 5,
          child: Container(
              color: Colors.black54,
              padding: EdgeInsets.all(3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Text(
                  formatDateMsByMS(widget.item.data.duration * 1000),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              )),
        ),
      ],
    );
  }

  Widget _itemDesc() {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "#${widget.item.data.category}/${widget.item.data.description}",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          ),
        ));
  }
}
