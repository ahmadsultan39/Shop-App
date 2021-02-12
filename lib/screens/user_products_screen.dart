import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import 'drawer_screen.dart';
import './add_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(AddProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: DrawerScreen(),
      body: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itmes.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                products.itmes[i].id,
                products.itmes[i].title,
                products.itmes[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
