import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/bloc/main/listing/listing.dart';
import 'package:my_instrument/bloc/main/listing/listing_edit.dart';

class ListingModule extends Module {
  @override
  final List<Bind> binds = [

  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:id',
      child: (_, args) => ListingPage(id: args.params['id'],),
      transition: TransitionType.fadeIn
    ),
    ChildRoute('/:id/edit',
      child: (_, args) => ListingEditPage(id: args.params['id']),
      transition: TransitionType.fadeIn
    )
  ];


}