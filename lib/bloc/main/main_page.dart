import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/services/main/message/message_service.dart';
import 'package:my_instrument/services/main/signalr/signalr_service.dart';
import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/shared/utils/list_parser.dart';
import 'package:my_instrument/services/models/responses/main/message/chat_message.dart';
import 'package:my_instrument/services/models/responses/main/message/unseen_message_member_model.dart';
import 'package:my_instrument/services/models/responses/main/message/unseen_message_member_response.dart';
import 'package:my_instrument/shared/theme/theme_methods.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:my_instrument/structure/route/router.gr.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> _unseenMessageMembers = List.empty(); // Store only the id's
  late final AuthModel model;
  late final StreamSubscription<List<Object>?> _receiveMessageSubscription;
  late final StreamSubscription<List<String>?> _readAllMessagesSubscription;

  final MessageService _messageService = AppInjector.get<MessageService>();
  final SignalRService _signalRService = AppInjector.get<SignalRService>();

  @override
  Widget build(BuildContext context) {
  return
    AutoTabsScaffold(
      extendBody: true,
      routes: const [
        HomeRoute(),
        FavRoute(),
        BlankRoute(),
        MessagesRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => _bottomNavBar(tabsRouter)
    );
  }

  @override
  void initState() {
    super.initState();
    _getUnseenMessageMembers();
    _receiveMessageSubscription = _signalRService.onReceiveMessage.listen(_handleReceiveMessage);
    _readAllMessagesSubscription = _signalRService.onReadAllMessages.listen(_handleReadAllMessages);
  }

  _handleReceiveMessage(List<Object>? messageList) {
    List<String> unseenMessageMembers = _unseenMessageMembers;
    ListParser.parse<ChatMessage>(messageList, ChatMessage.fromJson).forEach((chatMessage) {
      UnseenMessageMemberModelExtensions(unseenMessageMembers).addUnseenMessageMember(newUserId: chatMessage.userId);
    });

    setState(() {
      _unseenMessageMembers = unseenMessageMembers;
    });
  }

  _handleReadAllMessages(List<String>? userIds) {
    List<String> unseenMessageMembers = _unseenMessageMembers;

    userIds?.forEach((userId) {
      UnseenMessageMemberModelExtensions(unseenMessageMembers).removeUnseenMessageMember(userId: userId);
    });

    setState(() {
      _unseenMessageMembers = _unseenMessageMembers;
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
    _receiveMessageSubscription.cancel();
    _readAllMessagesSubscription.cancel();
    super.dispose();
  }

  Widget _bottomNavBar(TabsRouter tabsRouter) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CustomNavigationBar(
        iconSize: 30.0,
        selectedColor: getCustomTheme(context)?.LoginButtonText,
        strokeColor: getCustomTheme(context)?.LoginButtonText.withOpacity(0.1) ?? const Color(0xFF12B3F2),
        unSelectedColor: Colors.grey[600],
        backgroundColor: Theme.of(context).colorScheme.surface,
        borderRadius: const Radius.circular(20.0),
        items: [
          CustomNavigationBarItem(
            icon: const Icon(
              LineIcons.home,
            ),
          ),
          CustomNavigationBarItem(
            icon: const Icon(
              LineIcons.heart,
            ),
          ),
          CustomNavigationBarItem(
            icon: const Icon(
              LineIcons.plus,
            ),
          ),
          CustomNavigationBarItem(
            icon: const Icon(
              LineIcons.comments,
            ),
            badgeCount: _unseenMessageMembers.length,
            showBadge: (_unseenMessageMembers.length > 0)
          ),
          CustomNavigationBarItem(
            icon: const Icon(
              LineIcons.userAlt
            ),
          ),
        ],
        currentIndex: tabsRouter.activeIndex,
        onTap: (index) {
          if (index == 2) {
            AutoRouter.of(context).push(const NewListingRoute());
          } else {
            tabsRouter.setActiveIndex(index);
          }
        },
        isFloating: true,
      ),
    );
  }
}