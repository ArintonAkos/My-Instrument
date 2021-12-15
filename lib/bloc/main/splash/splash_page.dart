import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/services/main/signalr/signalr_service.dart';
import 'package:my_instrument/shared/widgets/gradient_interdeminate_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SplashPage extends StatelessWidget {
  late final AuthModel authModel;
  final SignalRService _signalRService = Modular.get<SignalRService>();

  SplashPage() {
    this.authModel = Modular.get<AuthModel>();
    _init();
  }

  void _init() async {
    await authModel.init();
    var prefs = await SharedPreferences.getInstance();
    await _signalRService.startService();
    if (prefs.getBool('boardingCompleted') == true) {
      Modular.to.navigate('/home/');
    } else {
      Modular.to.navigate('/onboard');
    }
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