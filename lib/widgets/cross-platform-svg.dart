import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrossPlatformSvg {
  static Widget asset({
    String assetPath = 'assets/logo.svg',
    String networkPath =
        'https://uca3b9f5856862337a430168fb24.previews.dropboxusercontent.com/p/thumb/AA-noZYFlwSGTmRaeitXYTLozePhdnd4E7ZBld_lhR8wsdin9kp3rxlnkOIVdci6Sahn05F7ix94sPOl4GJnHCxgN2Gtz3z8ZB0WSZsvYw6AYezC0w2GkXVSlloGJHwERSQAz_vacA3AM3y-qU37V_Wu5ogG6Ur4jlzhylLxqGhypblj8BGFbppWDNCUEkzNsn0GOUL8fRwx_jb-I31PfsBiwTiQdl0f2pbG43-uIbcqLbT1V3vFMAC9RqtRnupgFwGHHxeGjr2AHSJlqDr1UkxFnZoYPuqzKUbOjHPKXarmzAoEkhrjUglNoOl12DQkHYBPEaQKtdcZwrEuwDc3cN6lSGYR1KkEJX2_GpyWmvVNZwOHp2quFJxAY_CFRLva0T7pZC8UsosiNs66CD7yz_Qg/p.png?fv_content=true&size_mode=5',
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
