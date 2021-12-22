import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_instrument/bloc/main/splash/initialize_notifier.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/services/main/signalr/signalr_service.dart';
import 'package:my_instrument/shared/connectivity/network_connectivity.dart';

import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:my_instrument/shared/translation/app_language.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';

import 'package:provider/provider.dart';

import 'structure/route/router.gr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLanguage appLanguage = AppLanguage();
  final ThemeNotifier themeNotifier = ThemeNotifier();
  final InitializeNotifier initializeNotifier = InitializeNotifier();

  late final AuthModel _authModel;
  late final SignalRService _signalRService;
  late final NetworkConnectivity _connectivity = NetworkConnectivity.instance;

  final _appRouter = AppRouter();
  bool isSignedIn = false;

  @override
  void initState() {
    _initInjector();
    super.initState();
    _init();
  }

  _initInjector() {
    InjectorInitializer.initialize();
  }

  _updateSignedInState(bool signedIn) {
    if (signedIn != isSignedIn) {
      setState(() {
        isSignedIn = signedIn;
      });
    }
  }

  _init() async {
    _authModel = appInjector.get<AuthModel>();
    _authModel.authStream.listen((event) {
      _updateSignedInState(event);
    });

    await appLanguage.fetchLocale();
    _signalRService = appInjector.get<SignalRService>();

    Logger.root.onRecord.listen((record) => {
      print('${record.level.name}: ${record.time}: ${record.message}')
    });
    _connectivity.initialise();
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
          ChangeNotifierProvider<InitializeNotifier>(
            create: (_) => initializeNotifier,
          )
        ],
        child: Consumer3<AppLanguage, ThemeNotifier, InitializeNotifier>(builder: (context, language, theme, initialize, child) => (
          MaterialApp.router(
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
            title: 'MyInstrument',
            theme: theme.getTheme()?.materialTheme,
            routerDelegate: AutoRouterDelegate.declarative(
                _appRouter,
                routes: (_) => [
                  if (initialize.initialized)
                    if (isSignedIn)
                      const BaseRouter(children: [MainRoute()])
                    else if (initialize.boardingCompleted)
                      const AuthRouter(children: [LoginRoute()])
                    else
                      OnBoardRoute()
                  else
                    SplashRoute()
                ]),
            routeInformationParser: _appRouter.defaultRouteParser(includePrefixMatches: true),
          )
        )
      )
    );
  }

  @override
  void dispose() {
    _signalRService.stopService();
    _connectivity.disposeStream();
    _authModel.disposeAuthStream();
    super.dispose();
  }
}