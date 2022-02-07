import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';

class SearchField extends StatelessWidget {
  final double? width;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  const SearchField({
    Key? key,
    this.width,
    this.controller,
    this.onSubmitted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xFF979797).withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: onSubmitted,
        controller: controller,
        style: const TextStyle(
          fontSize: 18
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: AppLocalizations.of(context)!.translate('HOME.SEARCH.HINT'),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSurface
          )
        ),
      ),
    );
  }

  double getProportionateScreenHeight(double inputHeight, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return (inputHeight / 812.0) * screenHeight;
  }

  double getProportionateScreenWidth(double inputWidth, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (inputWidth / 375.0) * screenWidth;
  }
}