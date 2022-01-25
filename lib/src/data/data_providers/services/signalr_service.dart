import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/auth_model.dart';
import 'package:my_instrument/src/data/data_providers/services/http_service.dart';
import 'package:my_instrument/src/shared/connectivity/network_connectivity.dart';
import 'package:my_instrument/src/shared/utils/list_parser.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  final serverUrl = HttpService.hubUrl;
  late final HubConnection hubConnection;
  final hubProtocolLogger = Logger("SignalR - hub");
  final transportProtocolLogger = Logger("SignalR - transport");

  final AuthModel authModel = appInjector.get<AuthModel>();
  final NetworkConnectivity _connectivity = NetworkConnectivity.instance;

  final _onReceiveOwnMessage = StreamController<List<Object>?>.broadcast();
  Stream<List<Object>?> get onReceiveOwnMessage => _onReceiveMessage.stream;

  final _onReceiveMessage = StreamController<List<Object>?>.broadcast();
  Stream<List<Object>?> get onReceiveMessage => _onReceiveMessage.stream;

  final _onReadAllMessages = StreamController<List<String>>.broadcast();
  Stream<List<String>?> get onReadAllMessages => _onReadAllMessages.stream;

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
    hubConnection.on('ReceiveOwnMessage', _receiveOwnMessage);
    hubConnection.on('ReadAllMessages', _readAllMessages);
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

  void _receiveOwnMessage(List<Object>? arguments) {
    _onReceiveOwnMessage.sink.add(arguments);
  }

  void _readAllMessages(List<Object>? arguments) {
    _onReadAllMessages.sink.add(ListParser.parse<String>(arguments, (arg) => arg as String));
  }

  void stopService() async {
    await hubConnection.stop();
  }

  void dispose() {
    _onReceiveMessage.close();
  }
}