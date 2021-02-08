import '../providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_gird_view.dart';
import '../widgets/badge.dart';

enum Filtering { favourites, all }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shop App'),
          actions: [
            Consumer<Cart>(
              builder: (_, cart, child) => Badge(
                  child: IconButton(
                    icon: child,
                    onPressed: () {},
                  ),
                  value: cart.itemCount.toString()),
              child: Icon(Icons.shopping_cart_rounded),
            ),
            PopupMenuButton(
                onSelected: (value) {
                  setState(() {
                    if (value == Filtering.favourites)
                      _showFav = true;
                    else
                      _showFav = false;
                  });
                },
                itemBuilder: (ctx) => [
                      PopupMenuItem(
                          child: Text('Only favourites'),
                          value: Filtering.favourites),
                      PopupMenuItem(
                          child: Text('All products'), value: Filtering.all),
                    ])
          ],
        ),
        body: ProductsGridView(_showFav));
  }
}
