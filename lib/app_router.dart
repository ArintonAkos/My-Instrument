import 'package:auto_route/auto_route.dart';
import 'package:my_instrument/auth_pages/login.dart';
import 'package:my_instrument/home/home_page.dart';
import 'package:my_instrument/messages/messages.dart';
import 'package:my_instrument/new_listing/new_listing.dart';
import 'package:my_instrument/profile/user_settings_page.dart';
import 'package:my_instrument/screens/main/main_screen.dart';
import 'package:my_instrument/screens/splash/splash_page.dart';

import 'auth_pages/register.dart';
import 'fav/fav.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: MainPage,
      children: [
        AutoRoute(path: 'home', page: HomePage),
        AutoRoute(path: 'favorites', page: FavPage),
        AutoRoute(path: 'new-listing', page: NewListingPage),
        AutoRoute(path: 'messages', page: MessagesPage),
        AutoRoute(path: 'profile', page: UserPage),
      ],
    ),
    AutoRoute(path: '/login', page: LoginPage),
    AutoRoute(path: '/register', page: RegisterPage),
    AutoRoute(path: '/splashscreen', page: SplashPage, initial: true)
  ],
)
class $AppRouter {}