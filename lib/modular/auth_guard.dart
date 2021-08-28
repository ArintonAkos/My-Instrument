import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/services/auth/auth_model.dart';

class AuthGuard extends RouteGuard {
  final AuthModel authModel;
  final String guardedRoute;

  AuthGuard({
    required this.authModel,
    required this.guardedRoute
  }) : super(guardedRoute);

  @override
  Future<bool> canActivate(String url, ModularRoute route) {
    if (authModel.isSignedIn) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}