import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/bloc/auth/login.dart';
import 'package:my_instrument/bloc/auth/register.dart';
import 'package:my_instrument/bloc/main/fav/fav.dart';
import 'package:my_instrument/bloc/main/home/category/category.dart';
import 'package:my_instrument/bloc/main/home/home_page.dart';
import 'package:my_instrument/bloc/main/listing/listing.dart';
import 'package:my_instrument/bloc/main/main_screen.dart';
import 'package:my_instrument/bloc/main/messages/messages.dart';
import 'package:my_instrument/bloc/main/new_listing/new_listing.dart';
import 'package:my_instrument/bloc/main/onboard/onboard_page.dart';
import 'package:my_instrument/bloc/main/profile/user_settings_page.dart';
import 'package:my_instrument/bloc/main/splash/splash_page.dart';
import 'package:my_instrument/modular/auth_guard.dart';
import 'package:my_instrument/modular/custom_transitions/slide_transition.dart';
import 'package:my_instrument/modular/modules/listing_module.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/services/main/user/ratings.dart';

class AppModule extends Module {
  static AuthModel authModel = AuthModel();

  @override
  final List<Bind> binds = [
    Bind.singleton((i) => authModel),
    Bind.singleton((i) => RatingsService())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/home',
      child: (context, args) => const MainPage(),
      transition: TransitionType.scale,
      guards: [AuthGuard(authModel: authModel, guardedRoute: '/login')],
      children: [
        ChildRoute('/',
          child: (_, __) => const HomePage(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute('/favorites',
          child: (_, __) => const FavPage(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute('/new-listing',
          child: (_, __) => const NewListingPage(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute('/messages',
          child: (_, __) => const MessagesPage(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute('/profile',
          child: (_, __) => const UserPage(),
          transition: TransitionType.fadeIn,
        )
      ]
    ),
    ModuleRoute(
      '/listing',
      module: ListingModule(),
      guards: [AuthGuard(authModel: authModel, guardedRoute: '/login')],
    ),
    ChildRoute(
      '/category',
      child: (_, args) => CategoryPage(model: args.data,),
      transition: TransitionType.noTransition,
      guards: [AuthGuard(authModel: authModel, guardedRoute: '/login')]
    ),
    ChildRoute(
      '/onboard',
      child: (_, __) => OnBoardPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute('/login',
      child: (_, __) => LoginPage(),
      transition: TransitionType.custom,
      customTransition: slideTransition,
    ),
    ChildRoute('/register',
      child: (_, __) => RegisterPage(),
      transition: TransitionType.custom,
      customTransition: slideTransition,
    ),
    ChildRoute('/splash',
      child: (_, args) => SplashPage(),
      transition: TransitionType.custom,
      customTransition: slideTransition,
    )
  ];
}