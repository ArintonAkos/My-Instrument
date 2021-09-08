import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:my_instrument/shared/widgets/card_item.dart';

import '../user_settings_page.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Settings(settingsItems: aboutCards)
        )
      ),
    );
  }

}

const List<CardItemModel> aboutCards = [
  CardItemModel(
    icon: Icons.article,
    color: Color(0xfffc5c65),
    title: 'Licenses',
    description: 'Ensure your harvesting address',
  ),
  CardItemModel(
    icon: Icons.gavel,
    color: Color(0xff45aaf2),
    title: 'Terms of Service',
    description: 'Ensure your harvesting address',
  ),
  CardItemModel(
    icon: Icons.lock,
    color: Color(0xff26de81),
    title: 'Privacy Policy',
    description: 'Ensure your harvesting address',
  ),
];