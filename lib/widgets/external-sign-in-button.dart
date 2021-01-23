import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/opacity-button.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

enum EXTERNAL_SIGN_IN_TYPE { GOOGLE }

class ExternalSignInButton extends StatelessWidget {
  final EXTERNAL_SIGN_IN_TYPE loginType;
  final Function onTap;

  ExternalSignInButton({@required this.loginType, @required this.onTap});

  String _getSignInName() {
    switch (loginType) {
      case EXTERNAL_SIGN_IN_TYPE.GOOGLE:
        return "Google";
      default:
        return "";
    }
  }

  IconData _getSignInIcon() {
    switch (loginType) {
      case EXTERNAL_SIGN_IN_TYPE.GOOGLE:
        return FontAwesome5.google;
      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline5;
    final mainPadding = spacing[3] + spacing[1];
    return OpacityButton(
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(
            textStyle.fontSize + mainPadding / 2,
          ),
        ),
        padding: EdgeInsets.all(
          mainPadding,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getSignInIcon(),
              size: textStyle.fontSize * 1.5,
              color: Theme.of(context).accentColor,
            ),
            SizedBox(
              width: spacing[3],
            ),
            Text(
              "${translate(context, 'login_with')} ${_getSignInName()}",
              style: textStyle.copyWith(
                color: Theme.of(context).buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
