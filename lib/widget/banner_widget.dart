import 'package:flutter/material.dart';
import 'package:flutter_demo/http/cache_network_image_provider.dart';
import 'package:flutter_demo/utils/toast_utils.dart';
import 'package:flutter_demo/viewmodel/home/home_body_viewmodel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerWidget extends StatefulWidget {
  final HomeBodyViewModel model;

  const BannerWidget({Key key, this.model}) : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: cacheNetworkImage(
                      _cover(widget.model,  index)),
                        // widget.model.bannerList[index].data.cover.feed),
                    fit: BoxFit.cover,
                  )),
              // child:cacheNetworkImage(widget.model.bannerList[index].data.cover.feed),
            ),
            Positioned(
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  widget.model.bannerList[index].data.title,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              bottom: 0,
              width: MediaQuery.of(context).size.width - 30,
            )
          ],
        );
      },
      onTap: (index) {
        WgToast.showTip("点击了第$index个banner");
      },
      itemCount: widget.model.bannerList.length,
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          builder: DotSwiperPaginationBuilder()),
    );
  }
}

String _cover(HomeBodyViewModel model,int index){
  debugPrint("bannerItem4=${model.bannerList[index].data.cover.feed}");
  return model.bannerList[index].data.cover.feed;
}