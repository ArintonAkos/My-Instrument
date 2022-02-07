import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';

class ErrorInfo extends StatelessWidget {
  final String? fallbackText;

  const ErrorInfo({
    Key? key,
    this.fallbackText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              'assets/error.png',
              height: 125,
            ),
            const SizedBox(height: 20,),
            Text(
              fallbackText ?? AppLocalizations.of(context)?.translate('SHARED.ERROR.BASIC_MESSAGE') ?? '',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w400
              )
            ),
          ],
        ),
      ),
    );
  }
}
