import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/providers/auth.dart';
import 'package:WordFishing/services/db.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:WordFishing/widgets/external-sign-in-button.dart';
import 'package:WordFishing/widgets/full-screen-loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget with DrawerScreenProperties {
  static const routeName = "./Auth";

  @override
  final routeNameLocal = AuthScreen.routeName;

  @override
  final drawerButtonTranslationKey = "auth_screen_label";

  void _hideLoadingOverlay(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _showLoadingOverlay(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => FullScreenLoader(),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: Theme.of(context).textTheme.headline5,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void _googleSignInHandler(BuildContext context) {
    _showLoadingOverlay(context);
    Provider.of<AuthProvider>(context, listen: false).googleSignIn().then((_) {
      _hideLoadingOverlay(context);
    }).catchError((error) {
      _hideLoadingOverlay(context);
    });
  }

  void _saveToDatabase(BuildContext context) async {
    _showLoadingOverlay(context);
    final translationKey = await saveProvidersToDatabase(context);
    _hideLoadingOverlay(context);
    _showSnackBar(
      context,
      translate(
        context,
        translationKey,
      ),
    );
  }

  void _syncWithDatabase(BuildContext context) async {
    _showLoadingOverlay(context);
    final translationKey = await syncProvidersWithDatabase(context);
    _hideLoadingOverlay(context);
    _showSnackBar(
      context,
      translate(
        context,
        translationKey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = Theme.of(context).textTheme.headline5;
    final iconSize = buttonTextStyle.fontSize * 1.5;
    final iconColor = Theme.of(context).primaryColor;

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        "auth_screen_label",
        onDrawerIconPressed: () => _hideSnackBar(context),
      ),
      body: SafeArea(
        child: Center(
          child: !authProvider.isUserAuth
              ? ExternalSignInButton(
                  loginType: EXTERNAL_SIGN_IN_TYPE.GOOGLE,
                  onTap: () => _googleSignInHandler(context),
                )
              : ListView(
                  children: [
                    ListTile(
                      onTap: () => _saveToDatabase(context),
                      title: Text(
                        translate(context, 'save_to_cloud'),
                        style: buttonTextStyle,
                      ),
                      leading: Icon(
                        Icons.cloud_upload,
                        size: iconSize,
                        color: iconColor,
                      ),
                    ),
                    ListTile(
                      onTap: () => _syncWithDatabase(context),
                      title: Text(
                        translate(context, 'sync_with_cloud'),
                        style: buttonTextStyle,
                      ),
                      leading: Icon(
                        Icons.cloud_download,
                        size: iconSize,
                        color: iconColor,
                      ),
                    ),
                    ListTile(
                      onTap: authProvider.signOut,
                      title: Text(
                        translate(context, 'logout'),
                        style: buttonTextStyle,
                      ),
                      leading: Icon(
                        Icons.logout,
                        size: iconSize,
                        color: iconColor,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
