import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/src/presentation/pages/auth/register_page/register_page_inputs.dart';
import 'package:styled_widget/styled_widget.dart';

class RegisterPageBody extends StatelessWidget {
  const RegisterPageBody({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          const CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: RegisterPageInputs(),
                ),
              )
            ]
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Ink(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      shape: const CircleBorder(),
                    ),
                    child: IconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        AutoRouter.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: 26,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      splashRadius: 25,
                    )
                ).elevation(5,
                  borderRadius: BorderRadius.circular(26)
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}

