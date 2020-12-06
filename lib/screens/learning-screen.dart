import 'dart:math';

import 'package:WordFishing/models/learning-screen-arguments.dart';
import 'package:WordFishing/models/question.dart';
import 'package:WordFishing/models/vocabulary.dart';
import 'package:WordFishing/navigation/drawer-navigator.dart';
import 'package:WordFishing/navigation/routes-config.dart';
import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/providers/settings-provider.dart';
import 'package:WordFishing/screens/book-screen.dart';
import 'package:WordFishing/utils/translate.dart';
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

  int startingLength = 0;
  int currentIndex = 0;
  bool listFinished = false;
  bool listInitialized = false;

  @override
  void didChangeDependencies() {
    if (!listInitialized) _initializeList(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  void _initializeList(BuildContext context) {
    final LeariningScreenArguments learningScreenArguments =
        ModalRoute.of(context).settings.arguments;

    setState(() {
      questionsList = Provider.of<BooksProvider>(context).getQuestionsList(
          context,
          learningScreenArguments.bookId,
          learningScreenArguments.unitNumber);
      startingLength = questionsList.length;
      listInitialized = true;
      textFieldFocusNode.requestFocus();
    });
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
        print("GOOD ANSWER!");
      } else {
        print("WRONG ANSWER");
      }

      textFieldEditingController.clear();

      if (questionsList.length < 1) {
        textFieldFocusNode.unfocus();
        listFinished = true;
      } else {
        currentIndex = Random().nextInt(questionsList.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                print("SAVE CURRENT PROGRESS");
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
            return Column(
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
                            style: Theme.of(context).textTheme.headline4,
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
                    print("Submited");
                    if (!listFinished) _onSubmit();
                  },
                  textFieldFocusNode: textFieldFocusNode,
                  enabled: !listFinished,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
