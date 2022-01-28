import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget getBasicPageAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    iconTheme: IconThemeData(
      color: Theme.of(context).colorScheme.onSurface
    ),
    leading: IconButton(
      icon: const Icon(
        CupertinoIcons.back,
      ),
      onPressed: () {
        AutoRouter.of(context).pop();
      },
    ),
  );
}