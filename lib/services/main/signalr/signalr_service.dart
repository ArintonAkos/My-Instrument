import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/services/models/requests/signalr/chat_message.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../../http_service.dart';

class SignalRService {
  final serverUrl = HttpService.HubUrl;
  late final HubConnection hubConnection;
  final AuthModel authModel = Modular.get<AuthModel>();

  void startService() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl,
          options: HttpConnectionOptions(
            accessTokenFactory: () async => await authModel.getAccessToken()
          )
        )
        .build();
    ChatMessage chatMessage = ChatMessage('5e3c0d41-6e99-4359-b12c-40cc81f62016', 'ABcdadsa asdas');
    hubConnection.start()!.then((result) async {
      final result = await hubConnection.invoke("AddUser", args: <Object>[chatMessage]);
      print(result);
    });
  }

  void stopService() async {
    await hubConnection.stop();
  }
}