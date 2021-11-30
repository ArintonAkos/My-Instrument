import 'dart:async';

import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../../http_service.dart';

class SignalRService {
  final serverUrl = HttpService.ApiUrl;
  late final HubConnection hubConnection;
  bool isRunning = false;

  SignalRService() {
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
  }

  startService()
  {
    hubConnection.start();
  }

  stopService()
  {
    hubConnection.stop();
  }


}