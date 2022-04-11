import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instrument/src/business_logic/blocs/login_page/login_page_bloc.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/auth_model.dart';
import 'package:my_instrument/src/presentation/pages/auth/login_page/login_page_body.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';

class LoginPage extends StatelessWidget {
  final AuthModel _authModel = appInjector.get<AuthModel>();

  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginPageBloc(authModel: _authModel),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: const SafeArea(
          child: LoginPageBody()
        ),
      ),
    );
  }
}