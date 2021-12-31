// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i18;

import '../../bloc/auth/forgot_password.dart' as _i7;
import '../../bloc/auth/login.dart' as _i5;
import '../../bloc/auth/register.dart' as _i6;
import '../../bloc/base/error_page.dart' as _i2;
import '../../bloc/main/fav/fav.dart' as _i15;
import '../../bloc/main/home/home_page.dart' as _i14;
import '../../bloc/main/main_page.dart' as _i8;
import '../../bloc/main/messages/chatting_page.dart' as _i11;
import '../../bloc/main/messages/messages.dart' as _i16;
import '../../bloc/main/new_listing/new_listing.dart' as _i10;
import '../../bloc/main/onboard/onboard_page.dart' as _i4;
import '../../bloc/main/product_list/filter_data.dart' as _i19;
import '../../bloc/main/product_list/product_list_page.dart' as _i13;
import '../../bloc/main/profile/about/about.dart' as _i9;
import '../../bloc/main/profile/user_settings_page.dart' as _i17;
import '../../bloc/main/shopping_cart/shopping_cart_page.dart' as _i12;
import '../../bloc/main/splash/splash_page.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i18.GlobalKey<_i18.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    AuthRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    BaseRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    ErrorRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ErrorPage());
    },
    SplashRoute.name: (routeData) {
      final args = routeData.argsAs<SplashRouteArgs>(
          orElse: () => const SplashRouteArgs());
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.SplashPage(key: args.key));
    },
    OnBoardRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardRouteArgs>(
          orElse: () => const OnBoardRouteArgs());
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.OnBoardPage(key: args.key));
    },
    LoginRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.LoginPage());
    },
    RegisterRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RegisterRouteArgs>(
          orElse: () => RegisterRouteArgs(
              email: pathParams.optString('email'),
              name: pathParams.optString('name')));
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.RegisterPage(
              key: args.key, email: args.email, name: args.name));
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.ForgotPasswordPage());
    },
    MainRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.MainPage());
    },
    AboutRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.AboutPage());
    },
    NewListingRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.NewListingPage());
    },
    ChattingRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChattingRouteArgs>(
          orElse: () =>
              ChattingRouteArgs(userId: pathParams.getString('userId')));
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i11.ChattingPage(key: args.key, userId: args.userId));
    },
    ShoppingCartRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.ShoppingCartPage());
    },
    ProductListRoute.name: (routeData) {
      final args = routeData.argsAs<ProductListRouteArgs>();
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i13.ProductListPage(key: args.key, filterData: args.filterData));
    },
    HomeRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.HomePage());
    },
    FavRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.FavPage());
    },
    MessagesRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i16.MessagesPage());
    },
    ProfileRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i17.UserPage());
    },
    BlankRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(AuthRouter.name, path: '/auth/', children: [
          _i1.RouteConfig(LoginRoute.name,
              path: 'login', parent: AuthRouter.name),
          _i1.RouteConfig(RegisterRoute.name,
              path: 'register/:email:name', parent: AuthRouter.name),
          _i1.RouteConfig(ForgotPasswordRoute.name,
              path: 'forgot-password', parent: AuthRouter.name),
          _i1.RouteConfig('*#redirect',
              path: '*',
              parent: AuthRouter.name,
              redirectTo: 'login',
              fullMatch: true)
        ]),
        _i1.RouteConfig(BaseRouter.name, path: '/', children: [
          _i1.RouteConfig(MainRoute.name,
              path: 'main/',
              parent: BaseRouter.name,
              children: [
                _i1.RouteConfig(HomeRoute.name,
                    path: '', parent: MainRoute.name),
                _i1.RouteConfig(FavRoute.name,
                    path: 'favorites', parent: MainRoute.name),
                _i1.RouteConfig(MessagesRoute.name,
                    path: 'messages', parent: MainRoute.name),
                _i1.RouteConfig(ProfileRoute.name,
                    path: 'profile', parent: MainRoute.name),
                _i1.RouteConfig(BlankRoute.name,
                    path: 'blank', parent: MainRoute.name),
                _i1.RouteConfig('*#redirect',
                    path: '*',
                    parent: MainRoute.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i1.RouteConfig(AboutRoute.name,
              path: 'about', parent: BaseRouter.name),
          _i1.RouteConfig(NewListingRoute.name,
              path: 'new-listing/', parent: BaseRouter.name),
          _i1.RouteConfig(ChattingRoute.name,
              path: 'chat/:userId', parent: BaseRouter.name),
          _i1.RouteConfig(ShoppingCartRoute.name,
              path: 'cart', parent: BaseRouter.name),
          _i1.RouteConfig(ProductListRoute.name,
              path: 'products', parent: BaseRouter.name),
          _i1.RouteConfig('*#redirect',
              path: '*',
              parent: BaseRouter.name,
              redirectTo: '/main/',
              fullMatch: true)
        ]),
        _i1.RouteConfig(ErrorRoute.name, path: '/error'),
        _i1.RouteConfig(SplashRoute.name, path: '/splash'),
        _i1.RouteConfig(OnBoardRoute.name, path: '/onboard')
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class AuthRouter extends _i1.PageRouteInfo<void> {
  const AuthRouter({List<_i1.PageRouteInfo>? children})
      : super(AuthRouter.name, path: '/auth/', initialChildren: children);

  static const String name = 'AuthRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class BaseRouter extends _i1.PageRouteInfo<void> {
  const BaseRouter({List<_i1.PageRouteInfo>? children})
      : super(BaseRouter.name, path: '/', initialChildren: children);

  static const String name = 'BaseRouter';
}

/// generated route for
/// [_i2.ErrorPage]
class ErrorRoute extends _i1.PageRouteInfo<void> {
  const ErrorRoute() : super(ErrorRoute.name, path: '/error');

  static const String name = 'ErrorRoute';
}

/// generated route for
/// [_i3.SplashPage]
class SplashRoute extends _i1.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({_i18.Key? key})
      : super(SplashRoute.name,
            path: '/splash', args: SplashRouteArgs(key: key));

  static const String name = 'SplashRoute';
}

class SplashRouteArgs {
  const SplashRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.OnBoardPage]
class OnBoardRoute extends _i1.PageRouteInfo<OnBoardRouteArgs> {
  OnBoardRoute({_i18.Key? key})
      : super(OnBoardRoute.name,
            path: '/onboard', args: OnBoardRouteArgs(key: key));

  static const String name = 'OnBoardRoute';
}

class OnBoardRouteArgs {
  const OnBoardRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'OnBoardRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i1.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i6.RegisterPage]
class RegisterRoute extends _i1.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({_i18.Key? key, String? email, String? name})
      : super(RegisterRoute.name,
            path: 'register/:email:name',
            args: RegisterRouteArgs(key: key, email: email, name: name),
            rawPathParams: {'email': email, 'name': name});

  static const String name = 'RegisterRoute';
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key, this.email, this.name});

  final _i18.Key? key;

  final String? email;

  final String? name;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, email: $email, name: $name}';
  }
}

/// generated route for
/// [_i7.ForgotPasswordPage]
class ForgotPasswordRoute extends _i1.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(ForgotPasswordRoute.name, path: 'forgot-password');

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i8.MainPage]
class MainRoute extends _i1.PageRouteInfo<void> {
  const MainRoute({List<_i1.PageRouteInfo>? children})
      : super(MainRoute.name, path: 'main/', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i9.AboutPage]
class AboutRoute extends _i1.PageRouteInfo<void> {
  const AboutRoute() : super(AboutRoute.name, path: 'about');

  static const String name = 'AboutRoute';
}

/// generated route for
/// [_i10.NewListingPage]
class NewListingRoute extends _i1.PageRouteInfo<void> {
  const NewListingRoute() : super(NewListingRoute.name, path: 'new-listing/');

  static const String name = 'NewListingRoute';
}

/// generated route for
/// [_i11.ChattingPage]
class ChattingRoute extends _i1.PageRouteInfo<ChattingRouteArgs> {
  ChattingRoute({_i18.Key? key, required String userId})
      : super(ChattingRoute.name,
            path: 'chat/:userId',
            args: ChattingRouteArgs(key: key, userId: userId),
            rawPathParams: {'userId': userId});

  static const String name = 'ChattingRoute';
}

class ChattingRouteArgs {
  const ChattingRouteArgs({this.key, required this.userId});

  final _i18.Key? key;

  final String userId;

  @override
  String toString() {
    return 'ChattingRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i12.ShoppingCartPage]
class ShoppingCartRoute extends _i1.PageRouteInfo<void> {
  const ShoppingCartRoute() : super(ShoppingCartRoute.name, path: 'cart');

  static const String name = 'ShoppingCartRoute';
}

/// generated route for
/// [_i13.ProductListPage]
class ProductListRoute extends _i1.PageRouteInfo<ProductListRouteArgs> {
  ProductListRoute({_i18.Key? key, required _i19.FilterData filterData})
      : super(ProductListRoute.name,
            path: 'products',
            args: ProductListRouteArgs(key: key, filterData: filterData));

  static const String name = 'ProductListRoute';
}

class ProductListRouteArgs {
  const ProductListRouteArgs({this.key, required this.filterData});

  final _i18.Key? key;

  final _i19.FilterData filterData;

  @override
  String toString() {
    return 'ProductListRouteArgs{key: $key, filterData: $filterData}';
  }
}

/// generated route for
/// [_i14.HomePage]
class HomeRoute extends _i1.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i15.FavPage]
class FavRoute extends _i1.PageRouteInfo<void> {
  const FavRoute() : super(FavRoute.name, path: 'favorites');

  static const String name = 'FavRoute';
}

/// generated route for
/// [_i16.MessagesPage]
class MessagesRoute extends _i1.PageRouteInfo<void> {
  const MessagesRoute() : super(MessagesRoute.name, path: 'messages');

  static const String name = 'MessagesRoute';
}

/// generated route for
/// [_i17.UserPage]
class ProfileRoute extends _i1.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: 'profile');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class BlankRoute extends _i1.PageRouteInfo<void> {
  const BlankRoute() : super(BlankRoute.name, path: 'blank');

  static const String name = 'BlankRoute';
}
