import 'package:injector/injector.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/auth_model.dart';
import 'package:my_instrument/src/data/data_providers/services/auth_service.dart';
import 'package:my_instrument/src/data/data_providers/services/facebook_login_service.dart';
import 'package:my_instrument/src/data/data_providers/services/favorite_service.dart';
import 'package:my_instrument/src/data/data_providers/services/google_login_service.dart';
import 'package:my_instrument/src/data/data_providers/services/category_service.dart';
import 'package:my_instrument/src/data/data_providers/services/listing_service.dart';
import 'package:my_instrument/src/data/data_providers/services/message_service.dart';
import 'package:my_instrument/src/data/data_providers/services/profile_service.dart';
import 'package:my_instrument/src/data/data_providers/services/shopping_cart_service.dart';
import 'package:my_instrument/src/data/data_providers/services/signalr_service.dart';

class InjectorInitializer {
  static initialize() {
    appInjector.registerSingleton<GoogleLoginService>(() => GoogleLoginService());
    appInjector.registerSingleton<FacebookLoginService>(() => FacebookLoginService());
    appInjector.registerSingleton<AuthService>(() => AuthService());
    appInjector.registerSingleton<CategoryService>(() => CategoryService());
    appInjector.registerSingleton<FavoriteService>(() => FavoriteService());
    appInjector.registerSingleton<MessageService>(() => MessageService());
    appInjector.registerSingleton<ProfileService>(() => ProfileService());
    appInjector.registerSingleton<ListingService>(() => ListingService());
    appInjector.registerSingleton<ShoppingCartService>(() => ShoppingCartService());
    appInjector.registerSingleton<AuthModel>(() => AuthModel());
    appInjector.registerSingleton<SignalRService>(() => SignalRService());
  }
}

get appInjector {
  return Injector.appInstance;
}