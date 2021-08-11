import 'package:flutter/material.dart';
import 'package:flutter_demo/config/color.dart';
import 'package:flutter_demo/config/string.dart';

enum ViewState { loading, error, done }

class LoadingWidget extends StatefulWidget {
  final ViewState viewState;
  final Widget child;
  final Function retry;

  const LoadingWidget({Key key, this.viewState, this.child, this.retry})
      : super(key: key);

  @override
  _LoadingWidget createState() => _LoadingWidget();
}

class _LoadingWidget extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    if (ViewState.loading == widget.viewState) {
      return _LoadingCircleWidget();
    } else if (ViewState.error == widget.viewState) {
      return _ErrorWidget(
        retry: widget.retry,
      );
    } else {
      return widget.child;
    }
  }
}

class _ErrorWidget extends StatefulWidget {
  final Function retry;

  _ErrorWidget({Key key, this.retry}) : super(key: key);

  @override
  _ErrorWidgetState createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<_ErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _children(),
      ),
    );
  }

  List<Widget> _children() {
    return [
      Image.asset(
        "images/ic_error.png",
        width: 50,
        height: 50,
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          WgString.net_request_fail,
          style: TextStyle(fontSize: 18, color: WgColor.hitTextColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 15),
        child: OutlinedButton(
          onPressed: widget.retry,
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.white10),
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          child: Text(
            WgString.reload_again,
            style: TextStyle(fontSize: 20, color: WgColor.desTextColor),
          ),
        ),
      )
    ];
  }
}

class _LoadingCircleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
