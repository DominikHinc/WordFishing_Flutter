import 'dart:math';

import 'package:WordFishing/models/learning-screen-arguments.dart';
import 'package:WordFishing/models/vocabulary.dart';
import 'package:WordFishing/providers/books-provider.dart';
import 'package:WordFishing/theme/palette.dart';
import 'package:WordFishing/utils/translate.dart';
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
  List<Vocabulary> vocabularyList = [];

  final FocusNode textFieldFocusNode = FocusNode();
  final TextEditingController textFieldEditingController =
      TextEditingController();

  int currentIndex = 0;
  bool listInitialized = false;

  @override
  void didChangeDependencies() {
    if (!listInitialized) {
      final LeariningScreenArguments learningScreenArguments =
          ModalRoute.of(context).settings.arguments;
      vocabularyList = Provider.of<BooksProvider>(context).getUnitVocabulary(
          learningScreenArguments.bookId, learningScreenArguments.unitNumber);
      setState(() {
        listInitialized = true;
      });
    }

    super.didChangeDependencies();
  }

  void _onSubmit() {
    textFieldFocusNode.requestFocus();
    setState(() {
      currentIndex = Random().nextInt(vocabularyList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translate(context, widget.drawerButtonTranslationKey),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    textFieldFocusNode.unfocus();
                  },
                  child: Container(
                    height: constraints.maxHeight -
                        StickyTextInput.STICKY_TEXT_INPUT_HEIGHT,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor),
                    child: Center(
                      child: Text(
                        vocabularyList[currentIndex].pl,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                ),
                StickyTextInput(
                  textEditingController: textFieldEditingController,
                  onSubmit: () {
                    print("Submited");
                    _onSubmit();
                  },
                  textFieldFocusNode: textFieldFocusNode,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
