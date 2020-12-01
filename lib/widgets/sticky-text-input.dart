import 'package:WordFishing/utils/spacing.dart';
import 'package:WordFishing/utils/translate.dart';
import 'package:WordFishing/widgets/opacity-button.dart';
import 'package:flutter/material.dart';

class StickyTextInput extends StatefulWidget {
  static const STICKY_TEXT_INPUT_HEIGHT = 50;
  @override
  _StickyTextInputState createState() => _StickyTextInputState();
}

class _StickyTextInputState extends State<StickyTextInput> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeholderText = translate(context, "text_input_placeholder");
    return Container(
      height: StickyTextInput.STICKY_TEXT_INPUT_HEIGHT.toDouble(),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border(
          top: BorderSide(
            width: 1,
            color: theme.cardColor,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: spacing[2],
        horizontal: spacing[3],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(
            StickyTextInput.STICKY_TEXT_INPUT_HEIGHT / 2.0,
          ),
        ),
        padding:
            EdgeInsets.only(left: spacing[4], right: spacing[4], bottom: 1),
        child: Center(
          child: TextField(
            maxLines: 1,
            style: TextStyle(color: theme.textTheme.bodyText1.color),
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
              hintText: placeholderText,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: theme.cardColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: theme.cardColor),
              ),
              suffixIcon: OpacityButton(
                onPressed: () {},
                child: Icon(
                  Icons.chevron_right,
                  size: StickyTextInput.STICKY_TEXT_INPUT_HEIGHT.toDouble() -
                      spacing[4],
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
