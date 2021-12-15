import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/services/models/requests/signalr/chat_message_request.dart';
import 'package:my_instrument/shared/connectivity/network_connectivity.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../http_service.dart';

class SignalRService {
  final serverUrl = HttpService.HubUrl;
  late final HubConnection hubConnection;
  final hubProtocolLogger = Logger("SignalR - hub");
  final transportProtocolLogger = Logger("SignalR - transport");

  final AuthModel authModel = Modular.get<AuthModel>();
  final NetworkConnectivity _connectivity = NetworkConnectivity.instance;

  final _onReceiveMessage = StreamController<List<Object>?>.broadcast();
  Stream<List<Object>?> get onReceiveMessage => _onReceiveMessage.stream;

  void _setupHubConnection() {
    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl,
        options: HttpConnectionOptions(
            accessTokenFactory: () async => await authModel.getAccessToken(),
            logger: transportProtocolLogger,
            skipNegotiation: true,
            transport: HttpTransportType.WebSockets
        )
    )
        .withAutomaticReconnect()
        .configureLogging(hubProtocolLogger)
        .build();


    hubConnection.on('ReceiveMessage', _receiveMessage);
  }

  void _setupNetworkConnectivity() {
    _connectivity.myStream.listen((event) async {
      if (event != ConnectivityResult.none) { // There is Internet connection
        if (hubConnection.state == HubConnectionState.Disconnected) {
          await hubConnection.start();
        }
      }
    });
  }

  startService() {
    _setupHubConnection();
    hubConnection.start();

    _setupNetworkConnectivity();
  }

  void _receiveMessage(List<Object>? arguments) {
    _onReceiveMessage.sink.add(arguments);
  }

  void stopService() async {
    await hubConnection.stop();
  }

  void dispose() {
    _onReceiveMessage.close();
  }
}