import 'package:flutter/cupertino.dart';

enum Visibility {
  VISIBLE,
  GONE
}

extension on Visibility {
  bool get value {
    return [true, false][this.index];
  }
}

class BottomNavBarProps extends ChangeNotifier {
  bool isShowing = true;

  setVisibility(Visibility e) {
    isShowing = e.value;
  }

}