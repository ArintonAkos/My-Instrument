import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';

class ExitDialog extends StatefulWidget {
  final BuildContext rootContext;
  final Function dataManager;

    const ExitDialog({
      Key? key,
      required this.rootContext,
      required this.dataManager
    }) : super(key: key);

  @override
  _ExitDialogState createState() => _ExitDialogState();
}

class _ExitDialogState extends State<ExitDialog> {

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2.3,sigmaX: 2.3),
      child: AlertDialog(
        contentPadding: const EdgeInsets.only(left: 20,top: 35, bottom: 35),
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)!.translate('NEW_LISTING.EXIT_DIALOG.TITLE'),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            )
        ),
        content: Align(
          alignment: Alignment.centerLeft,
          heightFactor: 0,
          child: Text(
            AppLocalizations.of(context)!.translate('NEW_LISTING.EXIT_DIALOG.CONTENT'),
            style: const TextStyle(
                fontSize: 16
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            child: Text(
              AppLocalizations.of(context)!.translate('NEW_LISTING.EXIT_DIALOG.CANCEL'),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await widget.dataManager();
              Navigator.pop(widget.rootContext);
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context)!.translate('NEW_LISTING.EXIT_DIALOG.EXIT'),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
