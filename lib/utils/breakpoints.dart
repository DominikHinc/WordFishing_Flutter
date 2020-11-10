import 'package:flutter/material.dart';

enum AspectRatioBreakpoints { VERTICAL, HORIZONTAL }

getAspectRatioBreakpoint(BuildContext context) {
  return MediaQuery.of(context).size.width /
              MediaQuery.of(context).size.height >
          1
      ? AspectRatioBreakpoints.HORIZONTAL
      : AspectRatioBreakpoints.VERTICAL;
}
