import 'package:flutter/material.dart';
import 'package:flutter_demo/config/color.dart';
import 'package:flutter_demo/config/string.dart';

enum ViewState { loading, error, done }

class LoadingStateWidget extends StatefulWidget {
  final ViewState viewState;
  final VoidCallback retry;
  final Widget child;

  const LoadingStateWidget({Key key, this.viewState, this.retry, this.child})
      : super(key: key);

  @override
  _LoadingStateWidgetState createState() => _LoadingStateWidgetState();
}

class _LoadingStateWidgetState extends State<LoadingStateWidget> {
  @override
  Widget build(BuildContext context) {
    if (ViewState.loading == widget.viewState) {
      return LoadingWidget();
    } else if (ViewState.error == widget.viewState) {
      return ErrorNetWidget(
        retry: widget.retry,
      );
    } else {
      return widget.child;
    }
  }
}

///网络请求数据异常界面
class ErrorNetWidget extends StatefulWidget {
  final VoidCallback retry;

  const ErrorNetWidget({Key key, this.retry}) : super(key: key);

  @override
  _ErrorNetWidgetState createState() => _ErrorNetWidgetState();
}

class _ErrorNetWidgetState extends State<ErrorNetWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _children(),
        ),
      ),
    );
  }

  List<Widget> _children() {
    return [
      Image.asset(
        "images/ic_error.png",
        width: 44,
        height: 44,
      ),
      Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          WgString.net_request_fail,
          style: TextStyle(fontSize: 18, color: WgColor.hitTextColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          child: OutlinedButton(
            onPressed: widget.retry,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all(Colors.black12),
            ),
            child: Text(
              WgString.reload_again,
              style: TextStyle(fontSize: 20, color: WgColor.desTextColor),
            ),
          ),
        ),
      )
    ];
  }
}

///loading
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
