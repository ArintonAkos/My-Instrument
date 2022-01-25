import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/services/main/message/message_service.dart';
import 'package:my_instrument/services/main/profile/profile_service.dart';
import 'package:my_instrument/services/main/signalr/signalr_service.dart';
import 'package:my_instrument/services/models/requests/main/message/read_all_messages_request.dart';
import 'package:my_instrument/services/models/requests/main/message/send_message_request.dart';
import 'package:my_instrument/shared/utils/list_methods.dart';
import 'package:my_instrument/shared/utils/list_parser.dart';
import 'package:my_instrument/services/models/responses/main/message/chat_message.dart';
import 'package:my_instrument/services/models/responses/main/message/chat_message_response.dart';
import 'package:my_instrument/services/models/responses/main/profile/base_profile_response.dart';
import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChattingPage extends StatefulWidget {
  final String userId;

  const ChattingPage({
    Key? key,
    @PathParam('userId') required this.userId
  }) : super(key: key);

  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  late List<types.Message> _messages = [];

  final AuthModel _authModel = appInjector.get<AuthModel>();
  final ProfileService _profileService = appInjector.get<ProfileService>();
  final MessageService _messageService = appInjector.get<MessageService>();
  final SignalRService _signalRService = appInjector.get<SignalRService>();
  late final StreamSubscription<List<Object>?> _signalRSubscription;

  late final types.User _user;
  late types.User _partner;

  String fullName = '';
  bool isProfileLoading = false;
  bool areMessagesLoading = false;
  bool isFetchingNextPage = false;
  bool isLastPage = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _user = types.User(id: _authModel.userId ?? '');
    _partner = types.User(id: widget.userId);
    _notifyReadAllMessages();
    _initSubscription();
    _loadUserData();
    _loadMessages();
  }

  @override
  void dispose() {
    _signalRSubscription.cancel();
    super.dispose();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    var messageId = const Uuid().v4();

    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: messageId,
      text: message.text,
      status: types.Status.sending,
    );
    _addMessage(textMessage);

    var res = await _messageService.sendMessage(SendMessageRequest(
        toUserId: widget.userId,
        message: message.text
    ));


    if (res.ok) {
      final newTextMessage = textMessage.copyWith(
        status: types.Status.sent
      );

      setState(() {
        Replacing<types.Message>(_messages)
            .findAndReplaceInList(
              newTextMessage,
              searchCondition: (types.Message mess) => mess.id == messageId
            );
      });
    } else {
      final newTextMessage = textMessage.copyWith(
        status: types.Status.error
      );

      setState(() {
        _messages = Replacing<types.Message>(_messages)
            .findAndReplace(
            newTextMessage,
            searchCondition: (types.Message mess) => mess.id == messageId
        );
      });
    }
  }

  Future<void> _handleEndReached() async {
    if (!isFetchingNextPage) {
      setState(() {
        isFetchingNextPage = true;
      });

      await _loadMessages(page: ++_currentPage);

      setState(() {
        isFetchingNextPage = false;
      });
    }
  }

  Future<void> _notifyReadAllMessages() async {
    await _messageService.readAllMessages(ReadAllMessagesRequest(partnerId: widget.userId));
  }

  void _initSubscription() async {
    _signalRSubscription = _signalRService.onReceiveMessage.listen((event) async {
      List<types.Message> newMessages = _messages;

      ListParser
          .parse<ChatMessage>(event, (mess) => ChatMessage.fromJson(mess))
          .forEach((mess) {
            newMessages.insert(
              0,
              types.TextMessage(
                author: (mess.userId == _user.id) ? _user : _partner,
                id: const Uuid().v4(),
                createdAt: mess.creationDate.timeStamp,
                text: mess.message
              )
            );
          });

      setState(() {
        _messages = newMessages;
      });
      await _notifyReadAllMessages();
    });
  }

  void _loadUserData() async {
    isProfileLoading = true;
    var res = await _profileService.getBaseProfile(widget.userId);

    if (res.ok) {
      var baseProfileRes = res as BaseProfileResponse;

      _partner = _partner.copyWith(
        firstName: baseProfileRes.data?.baseName
      );
      setState(() {
        isProfileLoading = false;
        fullName = baseProfileRes.data?.baseName ?? '';
      });
    } else {
      setState(() {
        isProfileLoading = false;
      });
    }
  }

  Future<void> _loadMessages({ int page = 1 }) async {
    assert(page > 0);

    areMessagesLoading = true;
    var res = await _messageService.getMessages(widget.userId, page);
    if (res.ok) {
      var messageResponse = res as ChatMessageResponse;
      if (messageResponse.messageList.isEmpty) {
        setState(() {
          areMessagesLoading = false;
          isLastPage = true;
        });
      } else {
        List<types.Message> newMessages = _messages;
        newMessages.addAll(messageResponse.messageList.map(
                (e) =>
                types.TextMessage(
                    author: (e.userId == _user.id) ? _user : _partner,
                    id: const Uuid().v4(),
                    text: e.message,
                    createdAt: e.creationDate?.timeStamp
                )
        ).toList()
        );

        setState(() {
          areMessagesLoading = false;
          _messages = newMessages;
        });
      }
    } else {
      setState(() {
        areMessagesLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.textFieldBackgroundColor,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      AutoRouter.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                  ),
                  const SizedBox(width: 2,),
                  Avatar(
                    name: fullName,
                    shape: AvatarShape.circle(20),
                    useCache: true,
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        const SizedBox(height: 6,),
                        Text(
                          "Online",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 13
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Chat(
          messages: _messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          onEndReached: _handleEndReached,
          isLastPage: isLastPage,
          theme: DefaultChatTheme(
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          user: _user
        ),
      );
  }
}
