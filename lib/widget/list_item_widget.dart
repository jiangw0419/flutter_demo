import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/http/cache_network_image_provider.dart';
import 'package:flutter_demo/model/common_item.dart';
import 'package:flutter_demo/utils/date_format_utils.dart';
import 'package:flutter_demo/utils/navigator_utils.dart';
import 'package:flutter_demo/utils/route_material_app_utils.dart';
import 'package:flutter_demo/utils/share_utils.dart';

class ListItemWidget extends StatefulWidget {
  final Item item;

  final bool showCategory;

  final bool showDivider;

  ListItemWidget(
      {Key key, this.item, this.showCategory = true, this.showDivider = true})
      : super(key: key);

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _cover(widget.item),
        _author(widget.item),
        _divider(),
      ],
    );
  }

  _divider() {
    return Offstage(
      offstage: widget.showDivider,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Divider(
          color: Colors.black12,
          height: 0.5,
        ),
      ),
    );
  }

  _author(Item item) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          _authorIcon(),
          _videoDescription(),
          _share(),
        ],
      ),
    );
  }

  _authorIcon() {
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: cacheNetworkImageProvider(
        widget.item.data.author.icon,
        height: 44,
        width: 44,
      ),
    );
  }

  _videoDescription() {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.item.data.author.name == null
                    ? widget.item.data.title
                    : widget.item.data.author.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.item.data.author.description == null
                    ? widget.item.data.description
                    : widget.item.data.author.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              )
            ],
          ),
        ));
  }

  _share() {
    return GestureDetector(
      onTap: () {
        debugPrint(
            "share-content-----${widget.item.data.title}-${widget.item.data.description}");
        share(widget.item.data.title, widget.item.data.description);
      },
      child: Icon(Icons.share),
    );
  }

  _cover(Item item) {
    return GestureDetector(
        onTap: () {
          debugPrint("点击了，${item.data.id}");
          toName(ROUTE_VIDEO_DETIAL, arguments: item.data);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: cacheNetworkImageProvider(item.data.cover.feed),
              ),
              _category(),
              _videoTime(),
            ],
          ),
        ));
  }

  Widget _category() {
    return Positioned(
        left: 15,
        top: 10,
        child: Opacity(
            opacity: widget.showCategory ? 1.0 : 0.0,
            child: Container(
              height: 44,
              width: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(22)),
                color: Colors.white54,
              ),
              child: Text(
                widget.item.data.category,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            )));
  }

  Widget _videoTime() {
    return Positioned(
        right: 15,
        bottom: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            decoration: BoxDecoration(color: Colors.black54),
            padding: EdgeInsets.all(5),
            child: Text(
              formatDateMsByMS(widget.item.data.duration * 1000),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ));
  }
}
