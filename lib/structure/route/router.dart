import 'package:auto_route/auto_route.dart';
import 'package:my_instrument/bloc/auth/forgot_password.dart';
import 'package:my_instrument/bloc/auth/login.dart';
import 'package:my_instrument/bloc/auth/register.dart';
import 'package:my_instrument/bloc/main/fav/fav.dart';
import 'package:my_instrument/bloc/main/home/home_page.dart';
import 'package:my_instrument/bloc/main/main_page.dart';
import 'package:my_instrument/bloc/main/messages/chatting_page.dart';
import 'package:my_instrument/bloc/main/messages/messages.dart';
import 'package:my_instrument/bloc/main/new_listing/new_listing.dart';
import 'package:my_instrument/bloc/main/onboard/onboard_page.dart';
import 'package:my_instrument/bloc/main/profile/about/about.dart';
import 'package:my_instrument/bloc/main/profile/user_settings_page.dart';
import 'package:my_instrument/bloc/main/splash/splash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/auth/',
      name: 'AuthRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: 'login', page: LoginPage),
        AutoRoute(path: 'register', page: RegisterPage),
        AutoRoute(path: 'forgot-password', page: ForgotPasswordPage),
        RedirectRoute(path: '*', redirectTo: 'login')
      ]
    ),
    AutoRoute(
      path: '/',
      name: 'BaseRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: 'main/',
          page: MainPage,
          children: [
            AutoRoute(path: '', page: HomePage),
            AutoRoute(path: 'favorites', page: FavPage),
            AutoRoute(path: 'messages', page: MessagesPage),
            AutoRoute(path: 'profile', name: 'ProfileRoute', page: UserPage),
            AutoRoute(path: 'blank', name: 'BlankRoute', page: EmptyRouterPage),
            RedirectRoute(path: '*', redirectTo: '')
          ]
        ),
        AutoRoute(path: 'about', page: AboutPage),
        AutoRoute(path: 'new-listing/', page: NewListingPage),
        AutoRoute(path: 'chat/:userId', page: ChattingPage),
        RedirectRoute(path: '*', redirectTo: '/main/'),
      ]
    ),
    AutoRoute(path: '/splash', page: SplashPage),
    AutoRoute(path: '/onboard', page: OnBoardPage)
  ],
)
class $AppRouter {}