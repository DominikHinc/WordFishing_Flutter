import 'package:flutter/material.dart';

class OpacityButton extends StatefulWidget {
  final Widget child;
  final double baseOpacity;
  final double changedOpacity;
  final double baseTransform;
  final double changedTransform;
  final Function onPressed;
  OpacityButton(
      {@required this.child,
      this.baseOpacity = 1.0,
      this.changedOpacity = 0.6,
      this.baseTransform = 1.0,
      this.changedTransform = 0.95,
      this.onPressed});
  @override
  _OpacityButtonState createState() => _OpacityButtonState();
}

class _OpacityButtonState extends State<OpacityButton> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale:
          _pressed ? this.widget.changedTransform : this.widget.baseTransform,
      child: Opacity(
        opacity:
            _pressed ? this.widget.changedOpacity : this.widget.baseOpacity,
        child: GestureDetector(
          onTapDown: (details) {
            setState(() {
              _pressed = !_pressed;
            });
            widget.onPressed();
          },
          onTapUp: (details) {
            setState(() {
              _pressed = !_pressed;
            });
          },
          onTapCancel: () {
            Future.delayed(const Duration(milliseconds: 100), () {
              setState(() {
                _pressed = !_pressed;
              });
            });
          },
          child: this.widget.child,
        ),
      ),
    );
  }
}
