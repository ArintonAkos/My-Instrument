import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

Route<T> cupertinoRouteBuilder<T>(BuildContext context, Widget child, CustomPage<T> page) {
  return CupertinoPageRoute(
    fullscreenDialog: page.fullscreenDialog,
    settings: page,
    builder: (context) => child
  );
}