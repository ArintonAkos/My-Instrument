import 'package:auto_route/auto_route.dart';
import 'package:my_instrument/src/presentation/pages/auth/forgot_password_page/forgot_password.dart';
import 'package:my_instrument/src/presentation/pages/auth/login_page/login_page.dart';
import 'package:my_instrument/src/presentation/pages/auth/register_page/register_page.dart';
import 'package:my_instrument/src/presentation/pages/base/error_page.dart';
import 'package:my_instrument/src/presentation/pages/main/fav_page/fav.dart';
import 'package:my_instrument/src/presentation/pages/main/home_page/home_page.dart';
import 'package:my_instrument/src/presentation/pages/main/main_page.dart';
import 'package:my_instrument/src/presentation/pages/main/chatting_page/chatting_page.dart';
import 'package:my_instrument/src/presentation/pages/main/messages_page/messages_page.dart';
import 'package:my_instrument/src/presentation/pages/main/new_listing_page/new_listing_page.dart';
import 'package:my_instrument/src/presentation/pages/main/onboard_page/onboard_page.dart';
import 'package:my_instrument/src/presentation/pages/main/profile/about_page/about_page.dart';
import 'package:my_instrument/src/presentation/pages/main/profile/general_settings_page/general_settings_page.dart';
import 'package:my_instrument/src/presentation/pages/main/profile/general_settings_page/language_page/langauge_page.dart';
import 'package:my_instrument/src/presentation/pages/main/profile/user_settings_page/user_page.dart';
import 'package:my_instrument/src/presentation/pages/main/shopping_cart_page/shopping_cart_page.dart';
import 'package:my_instrument/src/presentation/pages/main/splash_page/splash_page.dart';
import 'package:my_instrument/src/presentation/pages/main/product_list_page/product_list_page.dart';
import 'package:my_instrument/structure/route/route_builders/cupertino_route_builder.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/auth/',
      name: 'AuthRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: 'login', page: LoginPage),
        CustomRoute(
          path: 'register/:email:name',
          page: RegisterPage,
          customRouteBuilder: cupertinoRouteBuilder
        ),
        CustomRoute(
          path: 'forgot-password',
          page: ForgotPasswordPage,
          customRouteBuilder: cupertinoRouteBuilder
        ),
        RedirectRoute(path: '*', redirectTo: 'login'),
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
            AutoRoute(
              path: 'profile/',
              name: 'ProfileRoute',
              page: UserPage,
            ),
            AutoRoute(path: 'blank', name: 'BlankRoute', page: EmptyRouterPage),
            RedirectRoute(path: '*', redirectTo: '')
          ]
        ),
        CustomRoute(
          path: 'about/',
          page: AboutPage,
          customRouteBuilder: cupertinoRouteBuilder
        ),
        CustomRoute(
          path: 'general-settings/',
          page: EmptyRouterPage,
          customRouteBuilder: cupertinoRouteBuilder,
          children: [
            CustomRoute(
              path: '',
              page: GeneralSettingsPage,
              customRouteBuilder: cupertinoRouteBuilder
            ),
            CustomRoute(
              path: 'language',
              page: LanguagePage,
              customRouteBuilder: cupertinoRouteBuilder
            ),
            RedirectRoute(path: '*', redirectTo: ''),
          ]
        ),
        CustomRoute(
          path: 'new-listing/',
          page: NewListingPage,
          customRouteBuilder: cupertinoRouteBuilder
        ),
        AutoRoute(path: 'chat/:userId', page: ChattingPage),
        CustomRoute(
          path: 'cart',
          page: ShoppingCartPage,
          customRouteBuilder: cupertinoRouteBuilder
        ),
        CustomRoute(
          path: 'products',
          page: ProductListPage,
          customRouteBuilder: cupertinoRouteBuilder
        ),
        RedirectRoute(path: '*', redirectTo: '/main/'),
      ]
    ),
    AutoRoute(path: '/error', page: ErrorPage),
    AutoRoute(path: '/splash', page: SplashPage),
    AutoRoute(path: '/onboard', page: OnBoardPage)
  ],
)
class $AppRouter {}