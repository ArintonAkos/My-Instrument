import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/models/chat_profile.dart';
import 'package:my_instrument/services/main/message/message_service.dart';
import 'package:my_instrument/services/main/signalr/signalr_service.dart';
import 'package:my_instrument/services/models/requests/main/message/message_request.dart';
import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/services/models/responses/list_parser.dart';
import 'package:my_instrument/services/models/responses/main/message/chat_message.dart';
import 'package:my_instrument/services/models/responses/main/message/message_response.dart';
import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:provider/provider.dart';


class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  List<ChatProfile> chatUsers = const [];
  final SignalRService _signalRService = Modular.get<SignalRService>();
  final MessageService _messageService = Modular.get<MessageService>();
  bool _mounted = false;

  @override
  void initState() {
    _mounted = true;
    _getMessageList();
    _signalRService.onReceiveMessage.listen((event) {
      List<ChatProfile> unseenMessageMembers = _updateUnseenMessageMembers(event);
      setState(() {
        chatUsers = unseenMessageMembers;
      });
    });
    super.initState();
  }

  _getMessageList() async {
    BaseResponse response = await _messageService.getMessageList();

    if (response.OK) {
      var res = response as MessageResponse;
      List<ChatProfile> chatProfiles = res.messageList
          .map((el) => ChatProfile.fromMessageModel(el))
          .toList();

      if (mounted) {
        setState(() {
          chatUsers = chatProfiles;
        });
      }
    }
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
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
                  Container(
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.LoginButtonText,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.LoginButtonsColor,
                          size: 20,
                        ),
                        const SizedBox(width: 2,),
                        Text(
                          "Add New",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.LoginButtonsColor
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(
                    color:  Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.TextFieldHintColor
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.TextFieldHintColor,
                  size: 20,
                ),
                filled: true,
                fillColor: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.TextFieldBackgroundColor,
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.TextFieldBackgroundColor ?? Colors.white,
                  ),
                ),
              ),
            ),
          ),
          ListView.builder(
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

          ),
        ],
      )
    );
  }

  List<ChatProfile> _updateUnseenMessageMembers(List<Object>? event) {
    List<ChatProfile> unseenMessageMembers = chatUsers;

    ListParser
        .parse<ChatMessage>(event, (mess) => ChatMessage.fromJson(mess))
        .forEach((element) {
          ChatProfile profile = ChatProfile(
            name: element.userName,
            time: element.creationDateString,
            userId: element.userId,
            messageText: element.message,
            isMessageRead: false,
          );

          if (unseenMessageMembers.isEmpty) {
            unseenMessageMembers.add(profile);
          } else {
            var searchedProfile = unseenMessageMembers.firstWhereOrNull((umm) => umm.userId == profile.userId);
            if (searchedProfile == null) {
              unseenMessageMembers.add(profile);
            }
          }
        });

    return unseenMessageMembers;
  }

}