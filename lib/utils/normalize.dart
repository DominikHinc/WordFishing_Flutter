import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

double normalizeFontSize(BuildContext context, double key) {
  return ResponsiveFlutter.of(context).fontSize(key);
}

double normalizeWidth(BuildContext context, double key) {
  return ResponsiveFlutter.of(context).scale(key);
}

double normalizeHeight(BuildContext context, double key) {
  return ResponsiveFlutter.of(context).verticalScale(key);
}

double normalizePadding(BuildContext context, double key) {
  return ResponsiveFlutter.of(context).moderateScale(key);
}
