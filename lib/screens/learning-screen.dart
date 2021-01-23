import 'dart:async';
import 'dart:math';

import 'package:WordFishing/models/learning-screen-arguments.dart';
import 'package:WordFishing/models/question.dart';
import 'package:WordFishing/providers/achievement-provider.dart';
import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/providers/progress-provider.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/achievement-popup.dart';
import 'package:WordFishing/widgets/custom-snackbar.dart';
import 'package:WordFishing/widgets/progress-bar.dart';
import 'package:WordFishing/widgets/sticky-text-input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LearningScreen extends StatefulWidget {
  static const routeName = './Learning';
  final drawerButtonTranslationKey = "learning_screen_label";

  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  List<Question> questionsList = [];

  final FocusNode textFieldFocusNode = FocusNode();
  final TextEditingController textFieldEditingController =
      TextEditingController();

  String bookId = "";
  String unitNumber = "";

  int startingLength = 0;
  int currentIndex = 0;
  bool listFinished = false;
  bool listInitialized = false;

  bool isSnackbarDisplayed = false;
  bool isLastAnswerCorrect = false;

  bool achievementDisplayed = false;

  Function completeUnitAchievement;

  Timer correctAnswerTimer;
  Timer achievementPopUpTimer;

  @override
  void didChangeDependencies() {
    if (!listInitialized) _initializeList(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    if (achievementPopUpTimer != null) achievementPopUpTimer.cancel();
    if (correctAnswerTimer != null) correctAnswerTimer.cancel();
    super.dispose();
  }

  void _initializeList(BuildContext context) {
    final LeariningScreenArguments learningScreenArguments =
        ModalRoute.of(context).settings.arguments;
    final achievementProvider = Provider.of<AchievementProvider>(
      context,
      listen: false,
    );
    final booksProvider = Provider.of<BooksProvider>(context);

    setState(() {
      bookId = learningScreenArguments.bookId;
      unitNumber = learningScreenArguments.unitNumber;

      if (learningScreenArguments.loadPreviouslySaved) {
        questionsList = Provider.of<ProgressProvider>(context).getUnitProgress(
          bookId,
          unitNumber,
        );

        // Wrokaround for issue with removing used provider value
        Future.delayed(Duration.zero, () {
          Provider.of<ProgressProvider>(context, listen: false)
              .deleteUnitProgress(
            bookId,
            unitNumber,
          );
        });
      } else {
        questionsList = booksProvider.getQuestionsList(
          context,
          learningScreenArguments.bookId,
          learningScreenArguments.unitNumber,
        );
      }

      if (!(achievementProvider
          .getBookCompletedUnits(bookId)
          .contains(unitNumber))) {
        completeUnitAchievement = achievementProvider.addUnitCompleted;
      }
      startingLength = learningScreenArguments.loadPreviouslySaved
          ? booksProvider.getVocabularyListWordCount(
              bookId,
              unitNumber,
            )
          : questionsList.length;
      listInitialized = true;
      textFieldFocusNode.requestFocus();
    });
  }

  void _displayWrongAnswerSnackbar() {
    setState(() {
      isLastAnswerCorrect = false;
      isSnackbarDisplayed = true;
      textFieldFocusNode.requestFocus();
    });
  }

  void _displayCorrectAnswerSnackbar() {
    setState(() {
      isLastAnswerCorrect = true;
      isSnackbarDisplayed = true;

      correctAnswerTimer = Timer(Duration(seconds: 1), () {
        setState(() {
          isSnackbarDisplayed = false;
        });
      });
    });
  }

  void _nextWord() {
    setState(() {
      textFieldEditingController.clear();
      currentIndex = Random().nextInt(questionsList.length);
      textFieldFocusNode.requestFocus();
    });
  }

  void _onListFinished() {
    textFieldFocusNode.unfocus();
    listFinished = true;
    if (completeUnitAchievement != null) {
      completeUnitAchievement(bookId, unitNumber);
      setState(() {
        achievementDisplayed = true;
        achievementPopUpTimer = Timer(
          Duration(seconds: 4),
          () {
            setState(() {
              achievementDisplayed = false;
            });
          },
        );
      });
    }
  }

  void _onSubmit() {
    textFieldFocusNode.requestFocus();

    setState(() {
      if (questionsList[currentIndex].answer.trim().toLowerCase() ==
          textFieldEditingController.text.trim().toLowerCase()) {
        if (questionsList[currentIndex].numberOfRepeats <= 1) {
          questionsList.removeAt(currentIndex);
        } else {
          questionsList[currentIndex].numberOfRepeats--;
        }
        if (questionsList.length < 1) {
          _onListFinished();
        } else {
          _displayCorrectAnswerSnackbar();
          _nextWord();
        }
      } else {
        _displayWrongAnswerSnackbar();
      }
    });
  }

  void onProgressSave(BuildContext context) {
    Provider.of<ProgressProvider>(context, listen: false)
        .addVocabularyProgressList(bookId, unitNumber, questionsList);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        translate(context, 'progress_saved'),
        style: Theme.of(context).textTheme.headline5,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: listInitialized
              ? ProgressBar(
                  currentProgress:
                      (startingLength - questionsList.length).toDouble(),
                  maxAmount: startingLength.toDouble(),
                )
              : Text(
                  translate(
                    context,
                    widget.drawerButtonTranslationKey,
                  ),
                ),
          actions: [
            Tooltip(
              message: translate(context, 'save_icon_tooltip'),
              child: IconButton(
                onPressed: () {
                  onProgressSave(context);
                },
                icon: Icon(
                  Icons.save,
                  color: Theme.of(context).buttonColor,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          textFieldFocusNode.unfocus();
                          if (listFinished) Navigator.of(context).pop();
                        },
                        child: Container(
                          height: constraints.maxHeight -
                              StickyTextInput.STICKY_TEXT_INPUT_HEIGHT,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight -
                                    StickyTextInput.STICKY_TEXT_INPUT_HEIGHT,
                              ),
                              child: Center(
                                child: Text(
                                  !listFinished
                                      ? questionsList[currentIndex].question
                                      : translate(
                                          context,
                                          'list_finished',
                                        ),
                                  style: Theme.of(context).textTheme.headline3,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      StickyTextInput(
                        textEditingController: textFieldEditingController,
                        onSubmit: () {
                          if (!listFinished && !isSnackbarDisplayed) {
                            _onSubmit();
                          } else {
                            textFieldFocusNode.requestFocus();
                          }
                        },
                        textFieldFocusNode: textFieldFocusNode,
                        enabled: !listFinished,
                      ),
                    ],
                  ),
                  CustomSnackbar(
                    isCorrect: isLastAnswerCorrect,
                    wrongMessageBottom: questionsList.length > 0
                        ? questionsList[currentIndex].answer
                        : "",
                    onPressed: () {
                      _nextWord();
                      setState(() {
                        isSnackbarDisplayed = false;
                      });
                    },
                    isDisplayed: isSnackbarDisplayed,
                  ),
                  AchievementPopup(
                    message: "${translate(context, "unit")} $unitNumber",
                    displayed: achievementDisplayed,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
