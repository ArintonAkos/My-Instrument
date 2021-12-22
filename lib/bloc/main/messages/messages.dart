import 'dart:async';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/models/chat_profile.dart';
import 'package:my_instrument/services/main/message/message_service.dart';
import 'package:my_instrument/services/main/signalr/signalr_service.dart';
import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/shared/utils/list_parser.dart';
import 'package:my_instrument/services/models/responses/main/message/chat_message.dart';
import 'package:my_instrument/services/models/responses/main/message/message_response.dart';
import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:my_instrument/shared/widgets/data-loader/data_loader.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  List<ChatProfile> chatUsers = const [];
  final SignalRService _signalRService = appInjector.get<SignalRService>();
  final MessageService _messageService = appInjector.get<MessageService>();
  late final StreamSubscription<List<Object>?> _signalRSubscription;
  late final StreamSubscription<List<String>?> _readAllMessageSubscription;

  bool _mounted = false;
  bool _isLoading = false;

  @override
  void initState() {
    _mounted = true;
    _getMessageList();
    _signalRSubscription = _signalRService.onReceiveMessage.listen((event) {
      List<ChatProfile> unseenMessageMembers = _updateMessageMembers(event);
      setState(() {
        chatUsers = unseenMessageMembers;
      });
    });
    _readAllMessageSubscription = _signalRService.onReadAllMessages.listen((event) {
      List<ChatProfile> unseenMessageMembers = _updateMessageMembersState(event);

      setState(() {
        chatUsers = unseenMessageMembers;
      });
    });

    super.initState();
  }

  _getMessageList() async {
    setState(() {
      _isLoading = true;
    });

    BaseResponse response = await _messageService.getMessageList();

    if (response.ok) {
      var res = response as MessageResponse;
      List<ChatProfile> chatProfiles = res.messageList
          .map((el) => ChatProfile.fromMessageModel(el))
          .toList();

      if (_mounted) {
        setState(() {
          chatUsers = chatProfiles;
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _mounted = false;
    _signalRSubscription.cancel();
    _readAllMessageSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Conversations",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.loginButtonText,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.loginButtonsColor,
                            size: 20,
                          ),
                          const SizedBox(width: 2,),
                          Text(
                            "Add New",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.loginButtonsColor
                            ),
                          ),
                        ],
                      )
                    )
                  ]
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(
                    color:  Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.textFieldHintColor
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.textFieldHintColor,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.textFieldBackgroundColor,
                  contentPadding: const EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.textFieldBackgroundColor ?? Colors.white,
                    ),
                ),
              ),
            ),
              DataLoader(
                isLoading: _isLoading,
                isError: false,
                itemBuilder: (BuildContext context) {
                  return ListView.builder(
                    itemCount: chatUsers.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatProfile(
                        name: chatUsers[index].name,
                        messageText: chatUsers[index].messageText,
                        imageUrl: chatUsers[index].imageUrl,
                        time: chatUsers[index].time,
                        isMessageRead: (index == 0 || index == 3)
                            ? true
                            : false,
                        userId: chatUsers[index].userId,
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      )
    );
  }

  List<ChatProfile> _updateMessageMembers(List<Object>? event) {
    List<ChatProfile> messageMembers = chatUsers;

    ListParser
        .parse<ChatMessage>(event, (mess) => ChatMessage.fromJson(mess))
        .forEach((element) {
          ChatProfile profile = ChatProfile(
            name: element.userName,
            time: element.creationDate,
            userId: element.userId,
            messageText: element.message,
            isMessageRead: false,
          );

          if (messageMembers.isEmpty) {
            messageMembers.add(profile);
          } else {
            var searchedProfile = messageMembers.firstWhereOrNull((umm) => umm.userId == profile.userId);
            if (searchedProfile == null) {
              messageMembers.add(profile);
            }
          }
        });

    return messageMembers;
  }

  List<ChatProfile> _updateMessageMembersState(List<String>? event) {
    List<ChatProfile> messageMembers = chatUsers;

    if (event != null) {
      for (var element in event) {
        final index = messageMembers.indexWhere((c) => c.userId == element);
        if (index != -1) {
          ChatProfile newMessageMember = messageMembers[index].copyWith(seen: true);
          messageMembers.removeAt(index);
          messageMembers.insert(index, newMessageMember);
        }
      }
    }

    return messageMembers;
  }
}