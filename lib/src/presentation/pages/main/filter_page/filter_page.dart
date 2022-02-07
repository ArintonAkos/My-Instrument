import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/theme/theme_methods.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({
    Key? key
  }) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  Widget buildActionButton(String buttonText, {
    Color? primary,
    Color? onPrimary,
    VoidCallback? onPressed
  }) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
          ),
          style: ElevatedButton.styleFrom(
            elevation: 5.0,
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
            ),
            primary: primary,
            onPrimary: onPrimary
          )
        ),
      ),
    );
  }

  Widget buildCancelButton() {
    return buildActionButton(
      AppLocalizations.of(context)!.translate('FILTER_PAGE.ACTION_BUTTON.CANCEL'),
      primary: Theme.of(context).backgroundColor,
      onPrimary: Theme.of(context).colorScheme.onSurface,
      onPressed: () => AutoRouter.of(context).pop()
    );
  }

  Widget buildAcceptButton() {
    return buildActionButton(
      AppLocalizations.of(context)!.translate('FILTER_PAGE.ACTION_BUTTON.ACCEPT'),
      primary: getCustomTheme(context)?.filterActionButtonColor,
      onPrimary: getCustomTheme(context)?.onFilterActionButtonColor,
      onPressed: () {

      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            AutoRouter.of(context).pop();
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Theme.of(context).colorScheme.onSurface,
          )
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Filters',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: const [
            PriceRange(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Theme.of(context).backgroundColor,
        // color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              buildCancelButton(),
              buildAcceptButton()
            ]
          ),
        )
      ),
    );
  }
}

class PriceRange extends StatefulWidget {
  const PriceRange({Key? key}) : super(key: key);

  @override
  _PriceRangeState createState() => _PriceRangeState();
}

class _PriceRangeState extends State<PriceRange> {
  SfRangeValues _values = const SfRangeValues(40.0, 80.0);

  Widget labelText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Price range",
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
          fontSize: 18,
          fontWeight: FontWeight.bold
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText(context),
          SfRangeSlider(
            min: 0.0,
            max: 100.0,
            values: _values,
            labelFormatterCallback: (actualValue, formattedText) => '$formattedText lei',
            showLabels: true,
            enableTooltip: true,
            minorTicksPerInterval: 1,
            stepSize: 1,
            onChanged: (SfRangeValues values){
              setState(() {
                _values = values;
              });
            },
          ),
        ],
      ),
    );
  }
}