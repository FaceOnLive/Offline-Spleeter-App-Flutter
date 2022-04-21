import 'package:flutter/material.dart';

class AppText {
  final BuildContext context;
  AppText(this.context);

  //Heading
  TextStyle get headline1 => Theme.of(context).textTheme.headline1!;
  TextStyle get headline2 => Theme.of(context).textTheme.headline2!;
  TextStyle get headline3 => Theme.of(context).textTheme.headline3!;
  TextStyle get headline4 => Theme.of(context).textTheme.headline4!;
  TextStyle get headline5 => Theme.of(context).textTheme.headline5!;
  TextStyle get headline6 => Theme.of(context).textTheme.headline6!;

  // Paragraph
  TextStyle get body1 => Theme.of(context).textTheme.bodyText1!;
  TextStyle get body2 => Theme.of(context).textTheme.bodyText2!;

  // Button
  TextStyle get button => Theme.of(context).textTheme.button!;
  TextStyle get caption => Theme.of(context).textTheme.caption!;
}
