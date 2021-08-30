import 'package:chewie/chewie.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/video/video_player_controller_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String playUrl;
  final bool autoPlay;
  final bool looping;
  final bool allowFullScreen;
  final double aspectRatio;
  final bool allowPlaybackSpeedChanging;

  const VideoPlayerWidget({Key key,
    this.playUrl,
    this.autoPlay = true,
    this.looping = true,
    this.allowFullScreen = true,
    this.aspectRatio = 16 / 9,
    this.allowPlaybackSpeedChanging = true})
      : super(key: key);

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    debugPrint("video player url ===${widget.playUrl}");
    _videoPlayerController = VideoPlayerController.network(widget.playUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      allowFullScreen: widget.allowFullScreen,
      aspectRatio: widget.aspectRatio,
      allowPlaybackSpeedChanging: widget.allowPlaybackSpeedChanging,
      customControls: VideoPlayerControllerWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width =  ScreenUtil.getInstance().screenWidth;
    double height = width / widget.aspectRatio;
    return Container(
      width: width,
      height: height,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  void play() {
    _chewieController.play();
  }

  void pause() {
    _chewieController.pause();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
