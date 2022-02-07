import 'package:flutter/material.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/auth_model.dart';
import 'package:styled_widget/styled_widget.dart';

class UserCard extends StatelessWidget {
  final AuthModel authModel;

  const UserCard({
    Key? key,
    required this.authModel
  }) : super(key: key);

  Widget _buildUserRow(BuildContext context) {
    return <Widget>[
      Icon(
        Icons.account_circle,
        color: Theme.of(context).colorScheme.onSurface,)
          .decorated(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(30),
      )
      .constrained(height: 50, width: 50)
      .padding(right: 10),
      <Widget>[
        Text(
          authModel.getUser()?.name ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ).padding(bottom: 5),
        Text(
          authModel.getUser()?.roles[0] ?? '',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    ].toRow();
  }

  Widget _buildUserStats() {
    return <Widget>[
      _buildUserStatsItem('846', 'Collect'),
      _buildUserStatsItem('51', 'Attention'),
      _buildUserStatsItem('267', 'Track'),
      _buildUserStatsItem('39', 'Coupons'),
    ]
      .toRow(mainAxisAlignment: MainAxisAlignment.spaceAround)
      .padding(vertical: 10);
  }

  Widget _buildUserStatsItem(String value, String text) => <Widget>[
    Text(value).fontSize(20).textColor(Colors.white).padding(bottom: 5),
    Text(text).textColor(Colors.white.withOpacity(0.6)).fontSize(12),
  ].toColumn();

  @override
  Widget build(BuildContext context) {
    return <Widget>[_buildUserRow(context), _buildUserStats()]
        .toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(horizontal: 20, vertical: 10)
        .decorated(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20)
    )
        .elevation(
          5,
          shadowColor: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
        )
        .height(175)
        .alignment(Alignment.center);
  }
}