import 'package:animations/animations.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_instrument/auth/server_constants.dart';
import 'package:my_instrument/messages/messages.dart';
import 'package:my_instrument/new_listing/new_listing.dart';
import 'package:my_instrument/profile/user_settings_page.dart';
import 'package:my_instrument/theme/theme_manager.dart';
import 'package:my_instrument/translation/app_language.dart';
import 'package:my_instrument/translation/app_localizations.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import 'auth/auth_model.dart';
import 'fav/fav.dart';
import 'home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLanguage appLanguage = AppLanguage();
  ThemeNotifier themeNotifier = ThemeNotifier();
  AuthModel authModel = AuthModel();

  await appLanguage.fetchLocale();
  await authModel.init();
  await Parse().initialize(ServerConstants.APPLICATION_ID, ServerConstants.PARSE_SERVER_URL,
      clientKey: ServerConstants.CLIENT_KEY, debug: true);

  runApp(MyApp(
    appLanguage: appLanguage,
    themeNotifier: themeNotifier,
    authModel: authModel,
  ));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  final ThemeNotifier themeNotifier;
  final AuthModel authModel;

  MyApp({Key? key,
    required this.appLanguage,
    required this.themeNotifier,
    required this.authModel,
  }) : super(key: key) {

  }

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
        ],
        child: Consumer2<AppLanguage, ThemeNotifier>(builder: (context, language, theme, child) => (
          MaterialApp(
            locale: language.appLocal,
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
            /*navigatorKey: locator<NavigationService>().navigatorKey,
            builder: (context, child) => MainPage(child: child),*/
            home: MainPage(),
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

  static const bottomNavbarRoutes = [
    HomePage(), // '/',
    FavPage(),// '/favorite',
    NewListingPage(), // '/new-listing',
    MessagesPage(),// '/messages',
    UserPage()// '/profile'
  ];

  void _changeSelectedIndex(int index) {
    if (index != selectedRouteId) {
      setState(() {
        selectedRouteId = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) => (
      Consumer<AuthModel>(
          builder: (_, model, __) => Scaffold(
              extendBody: true,
              body: SafeArea(
                  child: PageTransitionSwitcher(
                      transitionBuilder: (animChild, primaryAnimation,
                          secondaryAnimation) =>
                          FadeThroughTransition(
                              animation: primaryAnimation,
                              secondaryAnimation: secondaryAnimation,
                              child: animChild
                          ),
                      child: bottomNavbarRoutes[selectedRouteId]
                  )
              ),
              bottomNavigationBar: (
                  model.isSignedIn
                      ? CustomNavigationBar(
                    iconSize: 20.0,
                    selectedColor: Theme.of(context).colorScheme.onSurface,
                    strokeColor: Theme.of(context).colorScheme.onSurface,
                    currentIndex: selectedRouteId,
                    unSelectedColor: Colors.grey[600],
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    onTap: _changeSelectedIndex,
                    items: <CustomNavigationBarItem>[
                      CustomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.home),
                      ),
                      CustomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.heart),
                      ),
                      CustomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.plus),
                      ),
                      CustomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.comments),
                      ),
                      CustomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.user),
                      ),
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
