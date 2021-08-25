import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_instrument/auth/server_constants.dart';
import 'package:my_instrument/theme/theme_manager.dart';
import 'package:my_instrument/translation/app_language.dart';
import 'package:my_instrument/translation/app_localizations.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import 'auth/auth_model.dart';
import 'package:my_instrument/app_router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  final AppLanguage appLanguage = AppLanguage();
  final ThemeNotifier themeNotifier = ThemeNotifier();
  final AuthModel authModel = AuthModel();
  bool initialized = false;


  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await appLanguage.fetchLocale();
    await authModel.init();
    await Parse().initialize(ServerConstants.APPLICATION_ID, ServerConstants.PARSE_SERVER_URL,
        clientKey: ServerConstants.CLIENT_KEY, debug: true);

    setState(() {
      initialized = true;
    });
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
        child: Consumer3<AppLanguage, ThemeNotifier, AuthModel>(builder: (context, language, theme, model, child) => (
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
            title: 'Instrumental',
            theme: theme.getTheme(),
            routerDelegate: AutoRouterDelegate.declarative(
                _appRouter,
                routes: (routeInfo) => [
                  if (!initialized)
                    const SplashRoute()
                  else if (model.isSignedIn)
                    const MainRoute()
                  else
                    LoginRoute(nextPage: null)
                ]),
            routeInformationParser: _appRouter.defaultRouteParser(),
          )
        )
      )
    );
  }
}
