import 'package:flutter/material.dart';

class AppRoute {
  AppRoute(this.context);
  final BuildContext context;

  // to make things easier
  pushTo(Widget route, [dynamic arguments]) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => route));
  }

  pop([dynamic result]) {
    Navigator.of(context).pop(result);
  }
}
