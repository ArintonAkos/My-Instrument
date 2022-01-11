import 'package:flutter/material.dart';
import 'package:my_instrument/bloc/main/splash/initialize_notifier.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/shared/widgets/gradient_indeterminate_progress_bar.dart';
import 'package:my_instrument/src/data/data_providers/services/signalr_service.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  final AuthModel authModel = appInjector.get<AuthModel>();
  final SignalRService signalRService = appInjector.get<SignalRService>();

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