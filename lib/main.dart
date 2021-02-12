import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

import './screens/product_overview_screen.dart';
import './screens/product_details_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import 'screens/user_products_screen.dart';
import './screens/add_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            //create: (ctx) => Products(),
            value: Products()
            //  builder: (ctx) => Products(),
            ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          AddProductScreen.routeName: (ctx) => AddProductScreen(),
        },
      ),
    );
  }
}
