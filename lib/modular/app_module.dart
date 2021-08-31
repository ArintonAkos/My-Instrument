import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/bloc/auth/login.dart';
import 'package:my_instrument/bloc/auth/register.dart';
import 'package:my_instrument/bloc/main/fav/fav.dart';
import 'package:my_instrument/bloc/main/home/home_page.dart';
import 'package:my_instrument/bloc/main/main_screen.dart';
import 'package:my_instrument/bloc/main/messages/messages.dart';
import 'package:my_instrument/bloc/main/new_listing/new_listing.dart';
import 'package:my_instrument/bloc/main/profile/user_settings_page.dart';
import 'package:my_instrument/bloc/main/splash/splash_page.dart';
import 'package:my_instrument/modular/auth_guard.dart';
import 'package:my_instrument/services/auth/auth_model.dart';

class AppModule extends Module {
  static AuthModel authModel = AuthModel();

  @override
  final List<Bind> binds = [
    Bind.singleton((i) => authModel),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/home',
      child: (context, args) => MainPage(),
      guards: [AuthGuard(authModel: authModel, guardedRoute: '/login')],
      children: [
        ChildRoute('/', child: (_, __) => HomePage()),
        ChildRoute('/favorites', child: (_, __) => FavPage()),
        ChildRoute('/new-listing', child: (_, __) => NewListingPage()),
        ChildRoute('/messages', child: (_, __) => MessagesPage()),
        ChildRoute('/profile', child: (_, __) => UserPage()),
      ]
    ),
    ChildRoute('/login', child: (_, __) => LoginPage()),
    ChildRoute('/register', child: (_, __) => RegisterPage()),
    ChildRoute('/splash', child: (_, args) => SplashPage())
  ];
}