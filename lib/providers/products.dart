import 'package:flutter/foundation.dart';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://image.shutterstock.com/image-photo/yellow-silk-scarf-isolated-on-260nw-312765539.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get itmes {
    return [..._items];
  }

  List<Product> get favourites {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findId(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProduct(Product product) {
    if (product.id != null) {
      final i =_items.indexWhere((element) => element.id == product.id);
      _items[i] = product;
    } else {
      product = Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(product);
    }

    notifyListeners();
  }

  void deleteProduct(String id){
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
