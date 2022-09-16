import 'package:flutter/material.dart';

class EdgeAlert {
  static final int LENGTH_SHORT = 1; //1 seconds
  static final int LENGTH_LONG = 2; // 2 seconds
  static final int LENGTH_VERY_LONG = 3; // 3 seconds

  static final int TOP = 1;
  static final int BOTTOM = 2;

  static void show(BuildContext context,
      {required String title,
      required String description,
      required int duration,
      required int gravity,
      required Color backgroundColor,
      required Color borderColor,
      required IconData icon}) {
    OverlayView.createView(context,
        title: title,
        description: description,
        duration: duration,
        gravity: gravity,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        icon: icon);
  }
}

class OverlayView {
  static final OverlayView _singleton = new OverlayView._internal();

  factory OverlayView() {
    return _singleton;
  }

  //static OverlayState _overlayState;
  //static OverlayEntry _overlayEntry;
  static late OverlayState _overlayState;
  static late OverlayEntry _overlayEntry;
  static bool _isVisible = false;

  OverlayView._internal();

  static void createView(BuildContext context,
      {required String title,
      required String description,
      required int duration,
      required int gravity,
      required Color backgroundColor,
      required Color borderColor,
      required IconData icon}) {
    _overlayState = Navigator.of(context).overlay!;

    if (!_isVisible) {
      _isVisible = true;

      _overlayEntry = OverlayEntry(builder: (context) {
        return EdgeOverlay(
          title: title,
          description: description,
          overlayDuration: duration == null ? EdgeAlert.LENGTH_SHORT : duration,
          gravity: gravity == null ? EdgeAlert.TOP : gravity,
          backgroundColor:
              backgroundColor == null ? Colors.grey : backgroundColor,
          borderColor: borderColor == null ? Colors.grey : borderColor,
          icon: icon == null ? Icons.notifications : icon,
        );
      });

      _overlayState.insert(_overlayEntry);
    }
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry.remove();
  }
}

class EdgeOverlay extends StatefulWidget {
  final String title;
  final String description;
  final int overlayDuration;
  final int gravity;
  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;

  EdgeOverlay(
      {required this.title,
      required this.description,
      required this.overlayDuration,
      required this.gravity,
      required this.backgroundColor,
      required this.borderColor,
      required this.icon});

  @override
  _EdgeOverlayState createState() => _EdgeOverlayState();
}

class _EdgeOverlayState extends State<EdgeOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<Offset> _positionTween;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));

    if (widget.gravity == 1) {
      _positionTween =
          Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero);
    } else {
      _positionTween =
          Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0));
    }

    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _controller.forward();

    listenToAnimation();
  }

  listenToAnimation() async {
    _controller.addStatusListener((listener) async {
      if (listener == AnimationStatus.completed) {
        await Future.delayed(Duration(seconds: widget.overlayDuration));
        _controller.reverse();
        await Future.delayed(Duration(milliseconds: 700));
        OverlayView.dismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double bottomHeight = MediaQuery.of(context).padding.bottom;

    return Positioned(
      top: widget.gravity == 0 ? 0 : null,
      bottom: widget.gravity == 2 ? 0 : null,
      right: widget.gravity == 2 ? 0 : null,
      left: widget.gravity == 2 ? 0 : null,
      child: SlideTransition(
        position: _positionAnimation,
        child: Container(
          width: 800,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              border: Border(
                left: BorderSide(
                  color: widget.borderColor,
                  width: 5,
                ),
                top: BorderSide(
                  color: widget.borderColor,
                  width: 5,
                ),
              )),
          child: OverlayWidget(
            title: widget.title,
            description: widget.description,
            iconData: widget.icon,
          ),
        ),
      ),
    );
  }
}

class OverlayWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;

  OverlayWidget(
      {this.title = '', this.description = '', required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Row(
        children: <Widget>[
          AnimatedIcon(iconData: iconData),
          Padding(padding: EdgeInsets.only(right: 15)),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              title == null
                  ? Container()
                  : Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
              description == null
                  ? Container()
                  : Text(
                      description,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
            ],
          )),
        ],
      ),
    );
  }
}

class AnimatedIcon extends StatefulWidget {
  final IconData iconData;

  AnimatedIcon({required this.iconData});

  @override
  _AnimatedIconState createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<AnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0.8,
        upperBound: 1.1,
        duration: Duration(milliseconds: 600));

    _controller.forward();
    listenToAnimation();
  }

  listenToAnimation() async {
    _controller.addStatusListener((listener) async {
      if (listener == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (listener == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: _controller,
        child: Icon(
          widget.iconData,
          size: 35,
          color: Colors.white,
        ),
        builder: (context, widget) =>
            Transform.scale(scale: _controller.value, child: widget),
      ),
    );
  }
}
