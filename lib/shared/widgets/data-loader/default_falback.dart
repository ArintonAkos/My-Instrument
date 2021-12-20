import 'package:flutter/cupertino.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';

class DefaultFallback extends StatelessWidget {
  const DefaultFallback({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context)!.translate('SHARED.ERROR.BASIC_MESSAGE')
          )
        ],
      ),
    );
  }
}
