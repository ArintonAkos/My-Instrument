import 'package:flutter/cupertino.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.translate('HOME.TITLE'),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          )
        ]
      ),
    );
  }
}