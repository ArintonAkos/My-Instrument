import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_instrument/src/shared/theme/app_theme_data.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';

class CustomInputField extends StatelessWidget {

  final String formHint;
  final String title;
  final TextEditingController inputController;
  final TextInputType? textInputType;
  final int? characterNumber;
  final double? fSize;
  final List<TextInputFormatter>? inputFormatters;

  const CustomInputField({
    Key? key,
    required this.formHint,
    required this.title,
    required this.inputController,
    required this.textInputType,
    this.characterNumber,
    this.fSize,
    this.inputFormatters
  }) : super(key: key);

  static double get defaultFontSize => 20.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16.0
            ),
            children: [
              TextSpan(
                text: title,
              ),
            ]
          )
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: inputController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.translate('NEW_LISTING.ERROR_MESSAGE.INPUT_FIELD');
            }
            if (textInputType == TextInputType.number) {
              if (double.parse(value) < 0) {
                return AppLocalizations.of(context)!.translate('NEW_LISTING.ERROR_MESSAGE.NUMBER_INPUT');
              }
            }
            return null;
          },
          maxLines: 1000,
          minLines: 1,
          maxLength: characterNumber,
          keyboardType: textInputType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
            labelStyle: TextStyle(
              fontSize: fSize ?? defaultFontSize,
            ),
            hintText: formHint,
            helperText: '',
            enabledBorder: const UnderlineInputBorder(),
          ),
        ),
        // const SizedBox(height: 5)
      ],
    );
  }
}
