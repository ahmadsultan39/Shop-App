import 'package:flutter/material.dart';

import './orders_screen.dart';
import './user_products_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen();

  // Widget _buildListTile(String title, IconData icon, Function tapHandler) =>
  //     ListTile(
  //       leading: Icon(
  //         icon,
  //         size: 26,
  //         color: Colors.white,
  //       ),
  //       title: Text(
  //         title,
  //         style:
  //             TextStyle(fontFamily: 'Aton', fontSize: 24, color: Colors.white),
  //       ),
  //       onTap: tapHandler,
  //     );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('Hello Shop!'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shopping_bag_rounded),
          title: Text('Shop'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.receipt_long_rounded),
          title: Text('Orders'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Your Products'),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName);
          },
        )
      ]),
    );
  }
}
