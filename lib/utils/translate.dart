import 'package:WordFishing/services/app-localizations.dart';
import 'package:flutter/material.dart';

String translate(BuildContext context, String key) =>
    AppLocalizations.of(context).translate(key);
