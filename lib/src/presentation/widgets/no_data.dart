import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';

class NoData extends StatelessWidget {
  final String? fallbackText;

  const NoData({
    Key? key,
    this.fallbackText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        fallbackText ?? AppLocalizations.of(context)?.translate('SHARED.INFO.NO_DATA') ?? '',
        style: TextStyle(
          fontSize: 22,
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w400
        )
      ),
    );
  }
}