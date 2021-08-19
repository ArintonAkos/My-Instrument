import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_instrument/profile/user_settings_page.dart';
import 'package:my_instrument/theme/theme_manager.dart';
import 'package:my_instrument/translation/app_language.dart';
import 'package:my_instrument/translation/app_localizations.dart';
import 'package:provider/provider.dart';


import 'fav/fav.dart';
import 'home/home_page.dart';
import 'messages/messages.dart';
import 'new_listing/new_listing.dart';

void main() async {
  AppLanguage appLanguage = AppLanguage();
  ThemeNotifier themeNotifier = ThemeNotifier();
  WidgetsFlutterBinding.ensureInitialized();
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
    themeNotifier: themeNotifier,
  ));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  final ThemeNotifier themeNotifier;

  const MyApp({Key? key,
    required this.appLanguage,
    required this.themeNotifier})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AppLanguage>(
            create: (_) => appLanguage,
          ),
          Provider<ThemeNotifier>(
              create: (_) => themeNotifier
          )
        ],
        child: Consumer2<AppLanguage, ThemeNotifier>
          (builder: (context, model, theme, child) {
          return MaterialApp(
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
            title: 'Flutter Demo',
            theme: theme.getTheme(),
            home: const MainPage(),
          );
        })
    );

  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPageIndex = 0;

  void _changePageIndex(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  static const pages = [
    HomePage(),
    FavPage(),
    NewListingPage(),
    MessagesPage(),
    UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageTransitionSwitcher(
            transitionBuilder: (animChild, primaryAnimation,
                secondaryAnimation) =>
                FadeThroughTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    child: animChild
                ),
            child: pages[_selectedPageIndex],
          )
      ),
      bottomNavigationBar: CurvedNavigationBar(
          index: _selectedPageIndex,
          backgroundColor: Colors.transparent,
          color: Colors.blueAccent,
          items: const <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.favorite, size: 30, color: Colors.white),
            Icon(Icons.add, size: 30, color: Colors.white),
            Icon(Icons.message, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white)
          ],
          onTap: _changePageIndex
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
