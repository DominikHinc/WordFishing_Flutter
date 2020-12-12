import 'dart:async';
import 'dart:math' as math;
import 'package:WordFishing/models/drawer-screen-model.dart';
import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/providers/theme-provider.dart';
import 'package:WordFishing/services/analytics/analytics-events.dart';
import 'package:WordFishing/services/performance/prerformance-events.dart';
import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/custom-snackbar.dart';
import 'package:WordFishing/widgets/progress-bar.dart';
import 'package:WordFishing/widgets/sticky-text-input.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// THIS SCREEN IS USED FOR DEBUG PURPOUSES
class DebugScreen extends StatefulWidget with DrawerScreenProperties {
  static const routeName = "./DebugScreen";
  @override
  final routeNameLocal = routeName;
  @override
  final drawerButtonTranslationKey = "debug_screen_label";
  @override
  _DebugScreenState createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen>
    with SingleTickerProviderStateMixin {
  var isSwitched = false;
  var firebaseText = '';
  double currentProgress = 0.0;
  double height = 0.0;
  double opacity = 0.0;
  double size = 0.0;
  bool isDisplayed = false;
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context);
    final books = booksProvider.books;
    final textController = TextEditingController();
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: ProgressBar(
            maxAmount: 30,
            currentProgress: currentProgress,
          ),
          leading: Icon(Icons.arrow_back),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: constraints.maxHeight -
                          StickyTextInput.STICKY_TEXT_INPUT_HEIGHT,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              child: Text("+1"),
                              onPressed: () {
                                setState(() {
                                  currentProgress += 1;
                                });
                              },
                            ),
                            SizedBox(
                              height: spacing[2],
                            ),
                            FloatingActionButton(
                              child: Text("cor_bar"),
                              onPressed: () {
                                setState(() {
                                  isDisplayed = true;
                                  isCorrect = true;
                                  // Future.delayed(Duration(seconds: 2), () {
                                  //   setState(() {
                                  //     isDisplayed = false;
                                  //   });
                                  // });
                                });
                              },
                            ),
                            SizedBox(
                              height: spacing[2],
                            ),
                            FloatingActionButton(
                              child: Text("wr_bar"),
                              onPressed: () {
                                setState(() {
                                  isDisplayed = true;
                                  isCorrect = false;
                                  // Future.delayed(Duration(seconds: 2), () {
                                  //   setState(() {
                                  //     isDisplayed = false;
                                  //   });
                                  // });
                                });
                              },
                            ),
                            Text(
                                "Application Current Theme: ${isSwitched ? "Dark" : "Light"}"),
                            Consumer<ApplicationThemeProvider>(
                              builder: (_, theme, ___) => Switch(
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                  theme.switchTheme(
                                      value ? Themes.DARK : Themes.LIGHT);
                                },
                                value: isSwitched,
                              ),
                            ),
                            Text(
                              // NEW WAY OF TRANSLATING TEXT
                              translate(context, 'example_message'),
                              // THIS SHOULD BE THE DEFAULT WAY OF STYLING TEXT
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            FlatButton(
                              child: Text("Crash!"),
                              onPressed: () =>
                                  FirebaseCrashlytics.instance.crash(),
                            ),
                            FlatButton(
                              child: Text("Send performance event!"),
                              onPressed: () {
                                final performanceEvent =
                                    measureVocabularyLoadTime();
                                Timer(Duration(seconds: 5), () {
                                  print("Stopped measuring time");
                                  performanceEvent.stop();
                                });
                              },
                            ),
                            FlatButton(
                              child: Text("Send analytics event!"),
                              onPressed: () {
                                print("Event will be sent");
                                sendTestEvent();
                              },
                            ),
                            if (booksProvider.dataLoaded)
                              ...books.map((book) {
                                return Column(
                                  children: [
                                    Image.network(book.imgUrl),
                                    Text(book.title),
                                    Text(
                                        "Number of Units: ${book.numberOfUnits}"),
                                    ...book.units.map((unit) {
                                      return Column(
                                        children: [
                                          Text(
                                            "Unit ${unit.unitNumber}: ${unit.unitTitle}",
                                          ),
                                          // Uncommment to fry CPU
                                          // ...unit.vocabulary.map((translation) {
                                          //   return Text(
                                          //     "${translation.pl} - ${translation.en}",
                                          //   );
                                          // })
                                        ],
                                      );
                                    }).toList(),
                                  ],
                                );
                              }).toList()
                          ],
                        ),
                      ),
                    ),
                    StickyTextInput(
                      animatedContainerheight: height,
                      textEditingController: textController,
                      onSubmit: () {
                        print(textController.text);
                        textController.clear();
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomSnackbar(
                      isCorrect: isCorrect,
                      wrongMessageBottom:
                          "tesfjokbfsaikhbfdsjhbsfdkjfsbndkhdfsbkjfsdbkhasdbkisfdhvbkjasdnbadsikjhbasfdkjbdasjhbdsakojfasdbvkasdbnklsdfabsadkbaksdb",
                      onPressed: () {
                        setState(() {
                          isDisplayed = false;
                        });
                      },
                      isDisplayed: isDisplayed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
