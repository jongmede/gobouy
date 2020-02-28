import 'package:flutter/material.dart';
import 'package:juan_pos/database/database_helper.dart';
import 'package:juan_pos/model/product.dart';
import 'package:juan_pos/screen/product_page.dart';

class ProductListPage extends StatefulWidget {

  const ProductListPage();

  @override
  ProductListState createState() => new ProductListState();
}

class ProductListState extends State<ProductListPage> {

  DatabaseHelper _db = new DatabaseHelper();
  Future<List<Product>> _fetch;
  List<Product> _products = List<Product>();

  @override
  void initState() {
    super.initState();
    _fetch = _fetchProducts();
  }

  _addProductToList(Product product) {
    setState(() {
      _products.add(product);
    });
  }

  Future<List<Product>> _fetchProducts() async {
    _products = await _db.getProducts();
    return _products;
  }

  Widget _getEmptyWidget() {
    return FlatButton(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
                Icons.library_books,
                size: 128
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text('Add Product',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(Product(), _addProductToList, _updateProductToList)));
      },
    );
  }

  _updateProductToList(Product product) {
    setState(() {
      int index  = _products.indexWhere((_product) => _product.productId == _product.productId);
      _products[index] = product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _fetch,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                List<Widget> productWidgets = List<Widget>();
                _products.asMap().map((index, element) => MapEntry(index,
                    productWidgets.add(ListTile(
                      title: Text(_products[index].productName),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  content: Text('Delete ' + _products[index].productName + '?'),
                                  actions: [
                                    FlatButton(
                                      child: Text('No'),
                                      onPressed: () {
                                        Navigator.of(dialogContext).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        _db.deleteProduct(_products[index]);
                                        setState(() {
                                          _products.removeAt(index);
                                        });
                                        Navigator.of(dialogContext).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(Product.fromMap(_products[index].toMap()), _addProductToList, _updateProductToList)));
                      },
                    ))
                ));

                return Scaffold(
                  appBar: AppBar(
                    title: Text('Products'),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(Product(), _addProductToList, _updateProductToList)));
                        },
                      ),
                    ],
                  ),
                  body: Center(
                    child: productWidgets.length == 0 ? _getEmptyWidget() : ListView(
                      children: productWidgets,
                    ),
                  ),
                );
              },
            );
        }
      }
    );
  }
}
