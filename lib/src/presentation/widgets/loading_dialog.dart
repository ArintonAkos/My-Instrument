import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'gradient_indeterminate_progress_bar.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 1.5, sigmaX: 1.5),
        child: AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          titlePadding: const EdgeInsets.only(bottom: 0,left: 5,right: 5,top: 5),
          contentPadding: const EdgeInsets.only(bottom: 30,left: 5,right: 5,top: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const GradientIndeterminateProgressbar(
            height: 110,
            width: 110,
          ),
          content: Text(
            AppLocalizations.of(context)!.translate('SHARED.INFO.LOADING'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
