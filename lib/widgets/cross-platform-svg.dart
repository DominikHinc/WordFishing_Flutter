import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrossPlatformSvg {
  static Widget asset({
    String assetPath = 'assets/logo.svg',
    String networkPath = 'https://i.imgur.com/NEiooFy.png',
    double width = 60,
    double height = 60,
    BoxFit fit = BoxFit.contain,
    Color color,
    alignment = Alignment.center,
    String semanticsLabel,
  }) {
    // `kIsWeb` is a special Flutter variable that just exists
    // Returns true if we're on web, false for mobile
    if (kIsWeb) {
      return Image.network(
        networkPath,
        width: 90,
        height: 90,
        fit: fit,
        color: color,
        alignment: alignment,
      );
    } else {
      return SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
        placeholderBuilder: (_) => Container(
          width: 30,
          height: 30,
          padding: EdgeInsets.all(30),
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
