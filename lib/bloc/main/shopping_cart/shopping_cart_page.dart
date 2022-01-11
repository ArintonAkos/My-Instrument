import 'package:flutter/material.dart';
import 'package:my_instrument/bloc/main/home/widgets/search_field.dart';
import 'package:my_instrument/src/data/data_providers/services/shopping_cart_service.dart';
import 'package:my_instrument/shared/widgets/data-loader/default_loader.dart';
import 'package:my_instrument/shared/widgets/page_header_text.dart';
import 'package:my_instrument/src/data/models/responses/main/shopping_cart/get_cart_items_response.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';

import 'cart_item.dart';
import 'cart_item_data.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({
    Key? key
  }) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  final ShoppingCartService _shoppingCartService = appInjector.get<ShoppingCartService>();
  final _controller = TextEditingController();

  List<CartItemData> baseItems = [];
  List<CartItemData> filteredItems = [];

  void _filterCartItems() {
    final text = _controller.text;

    filteredItems = text.isNotEmpty
        ? baseItems.where((cartItem) => cartItem.description.contains(text)).toList()
        : baseItems;

    setState(() {});
  }

  Future<List<CartItemData>> getCartItems() async {
    var res = await _shoppingCartService.getCartItems();

    if (res.ok) {
      setState(() {
        baseItems = (res as GetCartItemsResponse).cartItems;
      });
      return baseItems;
    }

    throw Exception("Couldn't fetch data!");
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_filterCartItems);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                const PageHeaderText(text: 'Cart'),
                const SizedBox(height: 20,),
                SearchField(controller: _controller),
                const SizedBox(height: 20),
                DefaultLoader<List<CartItemData>>(
                  builder: (context) => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) => CartItem(
                        cartItemData: filteredItems[index],
                      )
                  ),
                  future: getCartItems(),
                  emptyFunction: () => filteredItems.isEmpty,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
