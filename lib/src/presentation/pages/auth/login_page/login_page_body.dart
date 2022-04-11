import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/business_logic/blocs/login_page/login_page_bloc.dart';

import '../../../../shared/translation/app_localizations.dart';
import 'login_page_email.dart';
import 'login_page_external.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginPageBloc, LoginPageState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    LineIcons.exclamationCircle,
                    color: Colors.white
                  ),
                  const SizedBox(width: 10,),
                  Flexible(
                    child: Text(
                      state.errorMessage ?? AppLocalizations.of(context)!.translate('SHARED.ERROR.BASIC_MESSAGE'),
                      maxLines: 2,
                      softWrap: false,
                      style: const TextStyle(
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 20.0),
            )
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: const [
                    LoginPageEmail(),
                    LoginPageExternal()
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
