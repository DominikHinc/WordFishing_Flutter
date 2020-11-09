import 'package:flutter/material.dart';

class DrawerAnimationProvider extends ChangeNotifier {
  bool _toggle = true;
  double _xOffset = 0;
  double _yOffset = 0;
  double _scaleFactor = 1;

  double get xOffset {
    return _xOffset;
  }

  double get yOffset {
    return _yOffset;
  }

  double get scaleFactor {
    return _scaleFactor;
  }

  bool get toggle {
    return _toggle;
  }

  void toggleTransform() {
    _xOffset = _toggle ? 260 : 0;
    _yOffset = _toggle ? 160 : 0;
    _scaleFactor = _toggle ? 0.6 : 1;
    _toggle = !_toggle;
    notifyListeners();
  }
}
