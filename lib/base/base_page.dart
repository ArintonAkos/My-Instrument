import 'package:my_instrument/navigation/bottom_nav_bar_props.dart';

abstract class BasePage {
  void HideNavBar(BottomNavBarProps navBarProps) {
    navBarProps.setVisibility(Visibility.GONE);
  }

  void ShowNavBar(BottomNavBarProps navBarProps) {
    navBarProps.setVisibility(Visibility.VISIBLE);
  }
}

abstract class IPageNoNavbar {
  void hideNavBar();
}

abstract class IPageNavbar {
  void showNavBar();
}

