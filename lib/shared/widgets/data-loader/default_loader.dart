import 'package:flutter/cupertino.dart';

import '../gradient_indeterminate_progress_bar.dart';
import '../no_data.dart';
import 'default_fallback.dart';

typedef DefaultItemBuilder = Widget Function(BuildContext context);
typedef EmptyFunction = bool Function();

class DefaultLoader<Type> extends StatelessWidget {
  final Future<Type>? future;
  final DefaultItemBuilder builder;
  final EmptyFunction? emptyFunction;

  const DefaultLoader({
    Key? key,
    required this.future,
    required this.builder,
    this.emptyFunction
  }) : super(key: key);

  bool hasData(AsyncSnapshot<Type> snapshot) {
    if (emptyFunction != null) {
      return emptyFunction!();
    }

    return snapshot.hasData;
  }

  double loaderHeight(BuildContext context) {
    return MediaQuery.of(context).size.height - 200;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Type>(
      future: future, // getCartItems()
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: loaderHeight(context),
            child: const Center(
              child: GradientIndeterminateProgressbar(
                width: 50,
                height: 50,
              ),
            ),
          );
        } else {
          if (snapShot.hasError) {
            return SizedBox(
              height: loaderHeight(context),
              child: const Center(
                child: DefaultFallback(),
              ),
            );
          } else if (hasData(snapShot)) {
            return SizedBox(
              height: loaderHeight(context),
              child: const Center(
                child: NoData(),
              ),
            );
          } else {
            return builder(context);
          }
        }
      }
    );
  }

}