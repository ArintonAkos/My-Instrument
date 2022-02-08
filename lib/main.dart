import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_instrument/src/business_logic/blocs/home_page/home_page_bloc.dart';
import 'package:my_instrument/src/business_logic/blocs/new_listing_page/new_listing_page_bloc.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/initialize_notifier.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/auth_model.dart';
import 'package:my_instrument/src/data/data_providers/services/shared_prefs.dart';
import 'package:my_instrument/src/data/repositories/category_repository.dart';
import 'package:my_instrument/src/data/repositories/listing_repository.dart';
import 'package:my_instrument/src/shared/connectivity/network_connectivity.dart';

import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:my_instrument/src/business_logic/blocs/favorite/favorite_bloc.dart';
import 'package:my_instrument/src/data/data_providers/services/signalr_service.dart';
import 'package:my_instrument/src/data/repositories/favorite_repository.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';

import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'structure/route/router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLanguage appLanguage = AppLanguage();
  final InitializeNotifier initializeNotifier = InitializeNotifier();
  late final FavoriteRepository favoriteRepository;
  late final FavoriteBloc favoriteBloc;

  late final AuthModel _authModel;
  late final SignalRService _signalRService;
  late final NetworkConnectivity _connectivity = NetworkConnectivity.instance;

  final _appRouter = AppRouter();
  bool isSignedIn = false;

  @override
  void initState() {
    _initInjector();
    _createBlocs();
    super.initState();
    _init();
  }

  _initInjector() {
    InjectorInitializer.initialize(appLanguage);
  }

  _createBlocs() {
    favoriteRepository = FavoriteRepository();
    favoriteBloc = FavoriteBloc(
      favoriteRepository: favoriteRepository
    );
  }

  _updateSignedInState(bool signedIn) {
    if (signedIn != isSignedIn) {
      handleSignedInState(signedIn);
      setState(() {
        isSignedIn = signedIn;
      });
    }
  }

  handleSignedInState(bool signedIn) {
    if (signedIn) {
      favoriteBloc.add(const LoadFavoritesEvent());
    } else {
      favoriteBloc.add(const ClearFavoritesEvent());
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => favoriteRepository),
        RepositoryProvider(create: (context) => CategoryRepository()),
        RepositoryProvider(create: (context) => ListingRepository()),
      ],
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider<AppLanguage>(
              create: (_) => appLanguage,
            ),
            ChangeNotifierProvider<ThemeNotifier>(
              create: (_) => ThemeNotifier()
            ),
            ChangeNotifierProvider<InitializeNotifier>(
              create: (_) => initializeNotifier,
            )
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => favoriteBloc,
              ),
              BlocProvider(
                create: (context) => HomePageBloc()
              ),
              BlocProvider(
                create: (context) => NewListingPageBloc(
                  categoryRepository: RepositoryProvider.of<CategoryRepository>(context),
                )..add(const GetCategoriesEvent()),
                lazy: false,
              )
            ],
            child: Consumer3<AppLanguage, ThemeNotifier, InitializeNotifier>(builder: (context, language, theme, initialize, child) => (
              MaterialApp.router(
                locale: language.appLocale,
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
                    navigatorObservers: () => [
                      FirebaseAnalyticsObserver(
                        analytics: FirebaseAnalytics.instance
                      ),
                      HeroController()
                    ],
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
        ),
          )
      ),
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