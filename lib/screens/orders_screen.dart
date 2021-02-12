import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../screens/drawer_screen.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: DrawerScreen(),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orders.orders[i]),
      ),
    );
  }
}
