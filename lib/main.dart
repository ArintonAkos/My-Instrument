import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/modular/app_module.dart';
import 'package:my_instrument/services/main/signalr/signalr_service.dart';
import 'package:my_instrument/shared/connectivity/network_connectivity.dart';

import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:my_instrument/shared/translation/app_language.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLanguage appLanguage = AppLanguage();
  final ThemeNotifier themeNotifier = ThemeNotifier();
  final SignalRService _signalRService = Modular.get<SignalRService>();
  final NetworkConnectivity _connectivity = NetworkConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _init();
    _signalRService.startService();
    /*_signalRService.hubConnection.onclose(({error}) {
      print(error);
    });*/
    _connectivity.initialise();
    _connectivity.myStream.listen((event) {
      if (event == ConnectivityResult.none) { // No Internet connection

      }
    });
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

  @override
  void dispose() {
    _signalRService.stopService();
    _connectivity.disposeStream();
    super.dispose();
  }
}