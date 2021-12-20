import 'package:flutter/cupertino.dart';
import 'package:my_instrument/shared/widgets/gradient_indeterminate_progress_bar.dart';

import 'default_falback.dart';

typedef FallbackBuilder = Widget Function(BuildContext context);
typedef ItemBuilder = Widget Function(BuildContext context);

class DataLoader extends StatefulWidget {
  const DataLoader({
    Key? key,
    required this.isLoading,
    required this.isError,
    this.fallbackBuilder,
    required this.itemBuilder,
    this.fallbackText
  }) : super(key: key);

  final bool isLoading;
  final bool isError;
  final FallbackBuilder? fallbackBuilder;
  final ItemBuilder itemBuilder;
  final String? fallbackText;

  @override
  State<StatefulWidget> createState() => _DataLoader();

}
class _DataLoader extends State<DataLoader> {

  Widget _getFallback(BuildContext context) {
    if (widget.fallbackBuilder == null) {
      return const DefaultFallback();
    }

    return widget.fallbackBuilder!(context);
  }

  Widget _getProgressBar(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: GradientIndeterminateProgressbar(
        width: 50,
        height: 50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.isLoading
          ? _getProgressBar(context)
          : widget.isError
            ? _getFallback(context)
            : widget.itemBuilder(context)
    );
  }
}
