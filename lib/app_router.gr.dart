// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import 'auth_pages/login.dart' as _i4;
import 'auth_pages/register.dart' as _i5;
import 'fav/fav.dart' as _i8;
import 'home/home_page.dart' as _i7;
import 'messages/messages.dart' as _i10;
import 'new_listing/new_listing.dart' as _i9;
import 'profile/user_settings_page.dart' as _i11;
import 'screens/main/main_screen.dart' as _i3;
import 'screens/splash/splash_page.dart' as _i6;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MainRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.MainPage();
        }),
    LoginRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<LoginRouteArgs>();
          return _i4.LoginPage(key: args.key, nextPage: args.nextPage);
        }),
    RegisterRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.RegisterPage();
        }),
    SplashRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.SplashPage();
        }),
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i7.HomePage();
        }),
    FavRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i8.FavPage();
        }),
    NewListingRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i9.NewListingPage();
        }),
    MessagesRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i10.MessagesPage();
        }),
    UserRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i11.UserPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MainRoute.name, path: '/', children: [
          _i1.RouteConfig(HomeRoute.name, path: 'home'),
          _i1.RouteConfig(FavRoute.name, path: 'favorites'),
          _i1.RouteConfig(NewListingRoute.name, path: 'new-listing'),
          _i1.RouteConfig(MessagesRoute.name, path: 'messages'),
          _i1.RouteConfig(UserRoute.name, path: 'profile')
        ]),
        _i1.RouteConfig(LoginRoute.name, path: '/login'),
        _i1.RouteConfig(RegisterRoute.name, path: '/register'),
        _i1.RouteConfig(SplashRoute.name, path: '/splashscreen')
      ];
}

class MainRoute extends _i1.PageRouteInfo {
  const MainRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'MainRoute';
}

class LoginRoute extends _i1.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i2.Key? key, required Object? nextPage})
      : super(name,
            path: '/login', args: LoginRouteArgs(key: key, nextPage: nextPage));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.nextPage});

  final _i2.Key? key;

  final Object? nextPage;
}

class RegisterRoute extends _i1.PageRouteInfo {
  const RegisterRoute() : super(name, path: '/register');

  static const String name = 'RegisterRoute';
}

class SplashRoute extends _i1.PageRouteInfo {
  const SplashRoute() : super(name, path: '/splashscreen');

  static const String name = 'SplashRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: 'home');

  static const String name = 'HomeRoute';
}

class FavRoute extends _i1.PageRouteInfo {
  const FavRoute() : super(name, path: 'favorites');

  static const String name = 'FavRoute';
}

class NewListingRoute extends _i1.PageRouteInfo {
  const NewListingRoute() : super(name, path: 'new-listing');

  static const String name = 'NewListingRoute';
}

class MessagesRoute extends _i1.PageRouteInfo {
  const MessagesRoute() : super(name, path: 'messages');

  static const String name = 'MessagesRoute';
}

class UserRoute extends _i1.PageRouteInfo {
  const UserRoute() : super(name, path: 'profile');

  static const String name = 'UserRoute';
}
