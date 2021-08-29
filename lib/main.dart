import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/modular/app_module.dart';

import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:my_instrument/shared/translation/app_language.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';

import 'package:provider/provider.dart';


void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLanguage appLanguage = AppLanguage();
  final ThemeNotifier themeNotifier = ThemeNotifier();

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await appLanguage.fetchLocale();
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
            theme: theme.getTheme()?.materialTheme,
            initialRoute: '/splash',
          ).modular()
        )
      )
    );
  }
}