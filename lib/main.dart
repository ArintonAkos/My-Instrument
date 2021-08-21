import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_instrument/auth_pages/login.dart';
import 'package:my_instrument/auth_pages/register.dart';
import 'package:my_instrument/fav/fav.dart';
import 'package:my_instrument/home/home_page.dart';
import 'package:my_instrument/messages/messages.dart';
import 'package:my_instrument/new_listing/new_listing.dart';
import 'package:my_instrument/profile/user_settings_page.dart';
import 'package:my_instrument/theme/theme_manager.dart';
import 'package:my_instrument/translation/app_language.dart';
import 'package:my_instrument/translation/app_localizations.dart';
import 'package:provider/provider.dart';

import 'auth/auth_model.dart';
import 'navigation/bottom_nav_bar_props.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLanguage appLanguage = AppLanguage();
  ThemeNotifier themeNotifier = ThemeNotifier();
  AuthModel authModel = AuthModel();
  BottomNavBarProps bottomNavBarProps = BottomNavBarProps();

  await appLanguage.fetchLocale();

  runApp(MyApp(
    appLanguage: appLanguage,
    themeNotifier: themeNotifier,
    authModel: authModel,
    bottomNavBarProps: bottomNavBarProps,
  ));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  final ThemeNotifier themeNotifier;
  final AuthModel authModel;
  final BottomNavBarProps bottomNavBarProps;

  MyApp({Key? key,
    required this.appLanguage,
    required this.themeNotifier,
    required this.authModel,
    required this.bottomNavBarProps,
    required
  })
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppLanguage>(
            create: (_) => appLanguage,
          ),
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => themeNotifier
          ),
          ChangeNotifierProvider<AuthModel>(
            create: (_) => authModel
          ),
          ChangeNotifierProvider<BottomNavBarProps>(
            create: (_) => bottomNavBarProps
          )
        ],
        child: Consumer2<AppLanguage, ThemeNotifier>(builder: (context, model, theme, child) => (
          MaterialApp(
            locale: model.appLocal,
            supportedLocales: const [
              Locale('en', ''),
              Locale('ro', ''),
              Locale('hu', '')
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            title: 'Instrumental',
            theme: theme.getTheme(),
            initialRoute: '/',
            routes: <String, WidgetBuilder> {
              '/': (BuildContext context) => HomePage(),
              '/favorites': (BuildContext context) => FavPage(),
              '/new-listing': (BuildContext context) => NewListingPage(),
              '/messages': (BuildContext context) => MessagesPage(),
              '/user': (BuildContext context) => UserPage(),
              '/login': (BuildContext context) => LoginPage(nextPage: null),
              '/register': (BuildContext context) => RegisterPage()
            },
            builder: (context, _,) => MainPage(),
          )
        )
      )
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  static int selectedRouteId = 0;

  static const routes = [
    HomePage(),
    FavPage(),
    NewListingPage(),
    MessagesPage(),
    UserPage(),
  ];

  void _changeSelectedIndex(int index) {
    setState(() {
      selectedRouteId = index;
    });
  }

  @override
  Widget build(BuildContext context) => (
    Consumer<AuthModel>(
      builder: (_, model, __) => Scaffold(
        body: SafeArea(
            child: PageTransitionSwitcher(
                transitionBuilder: (animChild, primaryAnimation,
                    secondaryAnimation) =>
                    FadeThroughTransition(
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        child: animChild
                    ),
                child: model.isSignedIn
                    ? routes[selectedRouteId]
                        : selectedRouteId == 0
                    ? routes[0]
                        : LoginPage(nextPage: routes[selectedRouteId],)
            )
        ),
        bottomNavigationBar: Consumer<BottomNavBarProps>(
          builder: (_, navbarProps, __) => navbarProps.isShowing
              ? CurvedNavigationBar(
                index: selectedRouteId,
                onTap: _changeSelectedIndex,
                backgroundColor: Colors.transparent,
                color: Colors.blueAccent,
                items: const <Widget>[
                  Icon(Icons.home, size: 30, color: Colors.white),
                  Icon(Icons.favorite, size: 30, color: Colors.white),
                  Icon(Icons.add, size: 30, color: Colors.white),
                  Icon(Icons.message, size: 30, color: Colors.white),
                  Icon(Icons.person, size: 30, color: Colors.white)
                ],
              )
              : SizedBox(
                height: 0,
              )
            )
          )
        )
    );

}
