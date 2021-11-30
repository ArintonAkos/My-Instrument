import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/models/chat_profile.dart';
import 'package:my_instrument/services/main/signalr/signalr_service.dart';
import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:provider/provider.dart';


class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<ChatProfile> chatUsers = const [
    ChatProfile(name: "Jane Russel", messageText: "Awesome Setup", time: "Now", isMessageRead: true),
    ChatProfile(name: "Glady's Murphy", messageText: "That's Great", time: "Yesterday", isMessageRead: true),
    ChatProfile(name: "Jorge Henry", messageText: "Hey where are you?", time: "31 Mar", isMessageRead: true),
    ChatProfile(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", time: "28 Mar", isMessageRead: true),
    ChatProfile(name: "Debra Hawkins", messageText: "Thank you, It's awesome", time: "23 Mar", isMessageRead: true),
    ChatProfile(name: "Jacob Pena", messageText: "will update you in evening", time: "17 Mar", isMessageRead: true),
    ChatProfile(name: "Andrey Jones", messageText: "Can you please share the file?", time: "24 Feb", isMessageRead: true),
    ChatProfile(name: "John Wick", messageText: "How are you?", time: "18 Feb", isMessageRead: true),
    ChatProfile(name: "John Wick", messageText: "How are you?", time: "18 Feb", isMessageRead: true),
    ChatProfile(name: "John Wick", messageText: "How are you?", time: "18 Feb", isMessageRead: true),
  ];

  final SignalRService _signalRService = Modular.get<SignalRService>();
  late StreamSubscription<Object?> _subscription;

  _fetchChatProfiles() async {
    _signalRService.startService();
    _subscription = _signalRService.hubConnection.stream('ReceiveMessage', [{}]).listen((event) {
      chatUsers.add(ChatProfile.fromStream(event));
    });
  }

  @override
  void initState() {
    _fetchChatProfiles();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
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
              );
            },
          ),
        ],
      )
    );
  }

}