import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avatars/avatars.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:styled_widget/styled_widget.dart';

class ChatProfile extends StatefulWidget {
  final String name;
  final String messageText;
  final String? imageUrl;
  final String time;
  final bool isMessageRead;

  const ChatProfile({
    Key? key,
    required this.name,
    required this.messageText,
    this.imageUrl,
    required this.time,
    required this.isMessageRead
  }) : super(key: key);

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ChatProfile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('/chat-hub');
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 10,
          right: 10
        ),
        child: Container(
          padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Avatar(
                      name: widget.name,
                      shape: AvatarShape.circle(22),
                      useCache: true,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 6,),
                            Text(
                              widget.messageText,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.time,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: widget.isMessageRead
                        ? FontWeight.bold
                        : FontWeight.normal
                )
              ),
            ],
          )
        )
        .borderRadius(all: 4)
        .ripple()
        .clipRRect(all: 25)
        .borderRadius(all: 25, animate: true)
        .animate(
          const Duration(milliseconds: 150),
          Curves.easeOut
        ),
      ),
    );
  }
}