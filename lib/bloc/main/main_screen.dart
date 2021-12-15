import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_instrument/bloc/main/i_auth_notifier.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/services/main/message/message_service.dart';
import 'package:my_instrument/services/main/signalr/signalr_service.dart';
import 'package:my_instrument/services/models/requests/signalr/chat_message_request.dart';
import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/services/models/responses/list_parser.dart';
import 'package:my_instrument/services/models/responses/main/message/chat_message.dart';
import 'package:my_instrument/services/models/responses/main/message/unseen_message_member_model.dart';
import 'package:my_instrument/services/models/responses/main/message/unseen_message_member_response.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> implements IAuthNotifier {
  int _selectedPageIndex = 0;
  List<String> _unseenMessageMembers = List.empty(); // Store only the id's
  late final AuthModel model;
  final MessageService _messageService = Modular.get<MessageService>();
  final SignalRService _signalRService = Modular.get<SignalRService>();
  // final FavoriteService _favoriteService = Modular.get<FavoriteService>();

  get _messageBadgeVisible {
    return (_unseenMessageMembers.isNotEmpty && _selectedPageIndex != 3);
  }

  void _changePageIndex(int id) {
    if (id  != _selectedPageIndex) {
      if (id == 0) {
        Modular.to.navigate('/home/');
      } else if (id == 1) {
        Modular.to.navigate('/home/favorites');
      } else if (id == 2) {
        Modular.to.navigate('/home/new-listing');
      } else if (id == 3) {
        Modular.to.navigate('/home/messages');
      } else if (id == 4) {
        Modular.to.navigate('/home/profile');
      }
      setState(() {
        _selectedPageIndex = id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: SafeArea(
        child: RouterOutlet(),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                gap: 6,
                activeColor: Theme.of(context).colorScheme.onSurface,
                iconSize: 20,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                tabs: [
                  const GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  const GButton(
                    icon: LineIcons.heart,
                    text: 'Favorites',
                  ),
                  const GButton(
                      icon: LineIcons.plus,
                      text: 'Create'
                  ),
                  GButton(
                    text: 'Messages',
                    icon: LineIcons.commentsAlt,
                    leading: _messageBadgeVisible
                      ? Badge(
                      badgeColor: Colors.red.shade100,
                      elevation: 0,
                      position: BadgePosition.topEnd(top: -12, end: -12),
                      badgeContent: Text(
                        _unseenMessageMembers.length.toString(),
                        style: TextStyle(color: Colors.red.shade900),
                      ),
                      child: const Icon(
                        LineIcons.commentsAlt,
                        size: 20,
                      ),
                    )
                      : null,
                  ),
                  const GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedPageIndex,
                onTabChange: _changePageIndex
              ),
            )
          )
      )
    );
  }

  @override
  onSignOut() {
    Modular.to.navigate('/login');
  }

  @override
  void initState() {
    super.initState();
    model = Modular.get<AuthModel>();
    model.setListener(this);
    _getUnseenMessageMembers();
    _signalRService.onReceiveMessage.listen((event) {
      List<String> unseenMessageMembers = _unseenMessageMembers;
      ListParser.parse<ChatMessage>(event, ChatMessage.fromJson).forEach((element) {
        UnseenMessageMemberModelExtensions(unseenMessageMembers).addUnseenMessageMember(newUserId: element.userId);
      });

      setState(() {
        _unseenMessageMembers = unseenMessageMembers;
      });
    });
  }

  _getUnseenMessageMembers() async {
    BaseResponse response = await _messageService.getUnseenMessageMembers();

    if (response.OK) {
      var unseenMessageResponse = response as UnseenMessageMemberResponse;

      setState(() {
        _unseenMessageMembers = unseenMessageResponse.UnseenMessageMembers.map((element) => element.UserId).toList();
      }) ;
    }
  }

  @override
  void dispose() {
    super.dispose();
    model.removeListener();
  }
}