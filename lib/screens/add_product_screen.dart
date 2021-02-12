import 'package:flutter/material.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // final _priceFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var product = Product(
    id: null,
    price: 0,
    title: '',
    description: '',
    imageUrl: '',
  );
  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
  var _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      final id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        product = Provider.of<Products>(context, listen: false).findId(id);
        _initValues = {
          'title': product.title,
          'price': product.price.toString(),
          'description': product.description,
        };
        _imageUrlController.text = product.imageUrl;
      }
      _init = false;
    }
    super.didChangeDependencies();
  }

  void _loadImage() {
    if (Uri.tryParse(product.imageUrl) == null) return;
    if (!_imageUrlFocusNode.hasFocus) setState(() {});
  }

  void _saveForm() {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    Provider.of<Products>(context, listen: false).addProduct(product);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_loadImage);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_loadImage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Data'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          //**use singleChildSV and column for long forms**
          padding: const EdgeInsets.all(15),
          children: [
            TextFormField(
              initialValue: _initValues['title'],
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) return "This can't be empty";
                return null;
              },
              onSaved: (value) {
                // FocusScope.of(context).requestFocus(_priceFocusNode);
                product = Product(
                  id: product.id,
                  title: value,
                  price: product.price,
                  description: product.description,
                  imageUrl: product.imageUrl,
                  isFavorite: product.isFavorite,
                );
              },
            ),
            TextFormField(
              initialValue: _initValues['price'],
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (double.tryParse(value) == null) return "Invalid input!!";
                return null;
              },
              onSaved: (value) {
                product = Product(
                  id: product.id,
                  title: product.title,
                  price: double.parse(value),
                  description: product.description,
                  imageUrl: product.imageUrl,
                  isFavorite: product.isFavorite,
                );
              },
              //   focusNode: _priceFocusNode,
            ),
            TextFormField(
              initialValue: _initValues['description'],
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              validator: (value) {
                if (value.isEmpty) return "This cat't be empty";
                if (value.length < 7) return "too short description";
                return null;
              },
              onSaved: (value) {
                product = Product(
                  id: product.id,
                  title: product.title,
                  price: product.price,
                  description: value,
                  imageUrl: product.imageUrl,
                  isFavorite: product.isFavorite,
                );
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(top: 15, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: _imageUrlController.text.isEmpty
                      ? Center(child: Text('Enter a URL'))
                      : Image.network(
                          _imageUrlController.text,
                          fit: BoxFit.contain,
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    validator: (value) {
                      if (value.isEmpty) return "This can't be empty";
                      if (Uri.tryParse(value) == null) return "Invalid Input";
                      //  if (!value.contains('.')) return "Invalid Input";
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    onSaved: (value) {
                      product = Product(
                        id: product.id,
                        title: product.title,
                        price: product.price,
                        description: product.description,
                        imageUrl: value,
                        isFavorite: product.isFavorite,
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
