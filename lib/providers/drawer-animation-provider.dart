import 'package:WordFishing/utils/breakpoints.dart';
import 'package:WordFishing/utils/normalize.dart';
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

  void toggleTransform(BuildContext context) {
    if (isScreenVertical(context)) {
      _xOffset = _toggle ? normalizeWidth(context, 260) : 0;
      _yOffset = _toggle ? normalizeHeight(context, 100) : 0;
      _scaleFactor = _toggle ? 0.6 : 1;
      _toggle = !_toggle;
    } else if (isScreenHorizontal(context)) {
      _xOffset = _toggle ? normalizeWidth(context, 100) : 0;
      _yOffset = 0;
      _scaleFactor = 1;
      _toggle = !_toggle;
    }
    notifyListeners();
  }
}
