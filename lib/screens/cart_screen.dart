import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart'; // as ci
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].title,
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity),
            ),
          ),
          //Spacer(),
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Total :',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.total.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  const Spacer(),
                  FlatButton(
                    onPressed: () {
                      Provider.of<Orders>(context,listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.total,
                      );
                      cart.clearCart();
                    },
                    child: Text(
                      'CONFRIM ORDER',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
