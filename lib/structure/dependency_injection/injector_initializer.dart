import 'package:injector/injector.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/auth_model.dart';
import 'package:my_instrument/src/data/data_providers/services/auth_service.dart';
import 'package:my_instrument/src/data/data_providers/services/category_cache_manager.dart';
import 'package:my_instrument/src/data/data_providers/services/category_filter_cache_manager.dart';
import 'package:my_instrument/src/data/data_providers/services/facebook_login_service.dart';
import 'package:my_instrument/src/data/data_providers/services/favorite_service.dart';
import 'package:my_instrument/src/data/data_providers/services/google_login_service.dart';
import 'package:my_instrument/src/data/data_providers/services/category_service.dart';
import 'package:my_instrument/src/data/data_providers/services/listing_service.dart';
import 'package:my_instrument/src/data/data_providers/services/message_service.dart';
import 'package:my_instrument/src/data/data_providers/services/profile_service.dart';
import 'package:my_instrument/src/data/data_providers/services/shared_preferences_service.dart';
import 'package:my_instrument/src/data/data_providers/services/shopping_cart_service.dart';
import 'package:my_instrument/src/data/data_providers/services/signalr_service.dart';


class InjectorInitializer {
  static initialize(AppLanguage appLanguage) {
    appInjector.registerSingleton<CategoryCacheManager>(() => CategoryCacheManager());
    appInjector.registerSingleton<CategoryFilterCacheManager>(() => CategoryFilterCacheManager());

    appInjector.registerSingleton<GoogleLoginService>(() => GoogleLoginService());
    appInjector.registerSingleton<FacebookLoginService>(() => FacebookLoginService());
    appInjector.registerSingleton<AuthService>(() => AuthService(appLanguage: appLanguage));
    appInjector.registerSingleton<CategoryService>(() => CategoryService(appLanguage: appLanguage));
    appInjector.registerSingleton<FavoriteService>(() => FavoriteService(appLanguage: appLanguage));
    appInjector.registerSingleton<MessageService>(() => MessageService(appLanguage: appLanguage));
    appInjector.registerSingleton<ProfileService>(() => ProfileService(appLanguage: appLanguage));
    appInjector.registerSingleton<ListingService>(() => ListingService(appLanguage: appLanguage));
    appInjector.registerSingleton<ShoppingCartService>(() => ShoppingCartService(appLanguage: appLanguage));
    appInjector.registerSingleton<AuthModel>(() => AuthModel());
    appInjector.registerSingleton<SignalRService>(() => SignalRService());
    appInjector.registerSingleton<SharedPreferencesService>(() => SharedPreferencesService());
  }
}

get appInjector {
  return Injector.appInstance;
}