// import 'package:Shop_App/providers/product.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGridView extends StatelessWidget {
  final _showFav;
  ProductsGridView(this._showFav);
  @override
  Widget build(BuildContext context) {
    final products = _showFav
        ? Provider.of<Products>(context).favourites
        : Provider.of<Products>(context).itmes;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //create: (ctx) => products[i],
        value: products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].imageUrl,
            // products[i].title,
            ),
      ),
      itemCount: products.length,
    );
  }
}
