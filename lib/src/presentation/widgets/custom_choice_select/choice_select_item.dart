import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/theme/theme_methods.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';

import 'choice_select.dart';

class ChoiceSelectItem extends StatelessWidget {
  final int length;
  final int index;
  final bool selected;
  final ChoiceSelect choice;
  final Function(int id) onTap;

  Color choiceColor(BuildContext context) => selected
    ? getCustomTheme(context)?.loginButtonText ?? Colors.white
    : Theme.of(context).backgroundColor;

  const ChoiceSelectItem({
    Key? key,
    required this.length,
    required this.index,
    required this.selected,
    required this.choice,
    required this.onTap
  }) : super(key: key);

  BorderRadius getBorderRadius() {
    if (index == 0) {
      if (index == length - 1) {
        return const BorderRadius.all(Radius.circular(10));
      }

      return const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10)
      );
    }
    if (index == length - 1) {
      return const BorderRadius.only(
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10)
      );
    }

    return BorderRadius.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        borderRadius: getBorderRadius(),
        onTap: () => onTap(choice.selectId),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            border: Border.all(
              color: getCustomTheme(context)?.loginButtonText ?? Colors.white
            ),
            borderRadius: getBorderRadius(),
            color: choiceColor(context),
          ),
          duration: const Duration(milliseconds: 200),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              AppLocalizations.of(context)!.translate(choice.text),
              style: TextStyle(
                color: (selected)
                  ? getCustomTheme(context)?.loginButtonsColor
                  : getCustomTheme(context)?.loginButtonText ?? Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          )
        ),
      ),
    );
  }
}