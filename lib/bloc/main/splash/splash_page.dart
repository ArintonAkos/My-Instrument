import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/bloc/main/splash/initialize_notifier.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/services/main/signalr/signalr_service.dart';
import 'package:my_instrument/shared/widgets/gradient_indeterminate_progress_bar.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:my_instrument/structure/route/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  final AuthModel authModel = AppInjector.get<AuthModel>();
  final SignalRService signalRService = AppInjector.get<SignalRService>();

  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late InitializeNotifier _initializeNotifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _initializeNotifier = Provider.of<InitializeNotifier>(context, listen: false);
      _initializeNotifier.init(widget, context);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Splash screen',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface
                  ),
                  textAlign: TextAlign.center,
                ),
                const GradientIndeterminateProgressbar()
              ],
            )
        )
    );
  }
}