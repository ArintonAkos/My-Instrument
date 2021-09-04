import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/bloc/main/fav/fav.dart';
import 'package:my_instrument/bloc/main/home/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [

  ];

  @override
  final List<ModularRoute> routes = [

    ChildRoute('/', child: (_, args) => HomePage()),
    ChildRoute('/favorites', child: (_, args) => FavPage()),

  ];

}