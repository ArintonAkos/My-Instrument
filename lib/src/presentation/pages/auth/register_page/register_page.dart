import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/src/presentation/pages/auth/register_page/register_page_body.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
    @PathParam('email') this.email,
    @PathParam('name') this.name,
  }) : super(key: key);

  final String? email;
  final String? name;

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: const SafeArea(
        child: RegisterPageBody()
      ),
    );
  }
}