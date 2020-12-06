import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/opacity-button.dart';
import 'package:flutter/material.dart';

class StickyTextInput extends StatelessWidget {
  static const STICKY_TEXT_INPUT_HEIGHT = 50;
  final TextEditingController textEditingController;
  final Function onSubmit;
  final double animatedContainerheight;
  final bool showSubmitIcon;
  final FocusNode textFieldFocusNode;
  bool enabled;
  StickyTextInput({
    @required this.textEditingController,
    @required this.onSubmit,
    this.showSubmitIcon = true,
    this.textFieldFocusNode,
    this.enabled,
    this.animatedContainerheight,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeholderText = translate(context, "text_input_placeholder");

    return Container(
      height: StickyTextInput.STICKY_TEXT_INPUT_HEIGHT.toDouble(),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: theme.cardColor,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: spacing[2],
        horizontal: spacing[3],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(
                  StickyTextInput.STICKY_TEXT_INPUT_HEIGHT / 2.0,
                ),
              ),
              padding: EdgeInsets.only(
                  left: spacing[4], right: spacing[4], bottom: 1),
              child: TextField(
                maxLines: 1,
                controller: textEditingController,
                onSubmitted: (value) {
                  onSubmit();
                },
                focusNode: textFieldFocusNode,
                style: TextStyle(color: theme.textTheme.bodyText1.color),
                enabled: enabled,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: theme.hintColor),
                  hintText: placeholderText,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.cardColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.cardColor),
                  ),
                ),
              ),
            ),
          ),
          if (showSubmitIcon)
            OpacityButton(
              onPressed: () {
                onSubmit();
              },
              child: Icon(
                Icons.play_arrow,
                size: StickyTextInput.STICKY_TEXT_INPUT_HEIGHT.toDouble() -
                    spacing[4],
                color: theme.accentColor,
              ),
            ),
        ],
      ),
    );
  }
}
