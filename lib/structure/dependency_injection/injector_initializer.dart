import 'package:injector/injector.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/services/auth/auth_service.dart';
import 'package:my_instrument/services/main/category/category_service.dart';
import 'package:my_instrument/services/main/message/message_service.dart';
import 'package:my_instrument/services/main/signalr/signalr_service.dart';

class InjectorInitializer {
  static initialize() {
    AppInjector.registerSingleton<AuthService>(() => AuthService());
    AppInjector.registerSingleton<CategoryService>(() => CategoryService());
    AppInjector.registerSingleton<MessageService>(() => MessageService());
    AppInjector.registerSingleton<AuthModel>(() => AuthModel());
    AppInjector.registerSingleton<SignalRService>(() => SignalRService());
  }
}

get AppInjector {
  return Injector.appInstance;
}