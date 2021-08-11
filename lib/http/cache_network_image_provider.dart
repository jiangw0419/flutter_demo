import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

ImageProvider cacheNetworkImage(String url) {
  return ExtendedNetworkImageProvider(url);
}

Widget cacheNetworkImageProvider(String url,
    {double width,
    double height,
    BoxFit fit = BoxFit.cover,
    bool cache = true,
    Border border,
    BorderRadius borderRadius,
    BoxShape shape,
    bool clearMemoryCacheWhenDispose = false}) {
  return ExtendedImage.network(
    url,
    width: width,
    height: height,
    fit: fit,
    cache: cache,
    border: border,
    shape: shape,
    borderRadius: borderRadius,
    clearMemoryCacheWhenDispose: clearMemoryCacheWhenDispose,
  );
}
