import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/navigation/routes-config.dart';
import 'package:WordFishing/providers/settings-provider.dart';
import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/custom-appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget with DrawerScreenProperties {
  static const routeName = "./Settings";

  final routeNameLocal = SettingsScreen.routeName;

  final drawerButtonTranslationKey = "settings_screen_label";

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    bool isDrawerRoute = ModalRoute.of(context).settings.name == INITIAL_ROUTE;
    return Scaffold(
      appBar: isDrawerRoute
          ? CustomAppBar(
              "settings_screen_label",
            )
          : AppBar(
              title: Text(
                translate(
                  context,
                  "settings_screen_label",
                ),
              ),
            ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(left: spacing[4]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${translate(context, "number_of_repeats")}${settingsProvider.numberOfRepeats.toStringAsFixed(0)}",
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Slider(
                      activeColor: Theme.of(context).accentColor,
                      inactiveColor: Theme.of(context).hintColor,
                      value: settingsProvider.numberOfRepeats.toDouble(),
                      min: 1,
                      max: 10,
                      onChanged: (newValue) {
                        settingsProvider
                            .changeNumberOfRepeats(newValue.toInt());
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${translate(context, "answer_language")}${settingsProvider.getAnswerLanguageTranslation(context)}",
                      ),
                      Text(
                        "${translate(context, "question_language")}${settingsProvider.getQuestionLanguageTranslation(context)}",
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: spacing[3]),
                    child: Switch(
                      value: settingsProvider.languageType ==
                          LanguageType.POLISH_ENGLISH,
                      onChanged: (changeValue) {
                        settingsProvider.switchLanguageType(changeValue
                            ? LanguageType.POLISH_ENGLISH
                            : LanguageType.ENGLISH_POLISH);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
