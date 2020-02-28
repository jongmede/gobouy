import 'package:flutter/material.dart';
import 'package:juan_pos/comp/labeled_checkbox.dart';
import 'package:juan_pos/database/database_helper.dart';
import 'package:juan_pos/model/category.dart';
import 'package:juan_pos/model/product.dart';
import 'package:juan_pos/util/decimal_text_input_formatter.dart';

class ProductPage extends StatefulWidget {

  final Product _product;
  final Function _addProductToList, _updateProductToList;

  ProductPage(this._product, this._addProductToList, this._updateProductToList);

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {

  DatabaseHelper _db = new DatabaseHelper();
  GlobalKey<FormState> _productFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<Category> _categories = List<Category>();

  @override
  void initState() {
    super.initState();

    _db.getCategories().then((list) => setState(() {
      _categories = list;
    }));
  }

  _submit(BuildContext context) async {
    if (!_productFormKey.currentState.validate()) {
      return;
    }

    if (widget._product.productId != null) {
      await _db.updateProduct(widget._product);
      widget._updateProductToList(widget._product);
      _globalKey.currentState.showSnackBar(new SnackBar(content: Text('Product updated!')));
    }
    else {
      int id = await _db.saveProduct(widget._product);
      widget._product.productId = id;
      widget._addProductToList(widget._product);
      _globalKey.currentState.showSnackBar(new SnackBar(content: Text('Product added!')));
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Product'),
      ),
      body: Form(
        key: _productFormKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'PRODUCT NAME'),
                initialValue: widget._product.productName ?? '',
                validator: (value) {
                  return value.isEmpty ? 'Product name is blank.' : null;
                },
                onChanged: (value) {
                  widget._product.productName = value;
                },
              ),
              Listener(
                onPointerDown: (_) => FocusScope.of(context).unfocus(),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'CATEGORY'),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      child: Text(category.categoryName),
                      value: category.categoryId
                    );
                  }).toList(),
                  value: widget._product.categoryId ?? (_categories.length > 0 ? _categories.elementAt(0).categoryId : 0),
                  onChanged: (value) {
                    setState(() {
                      widget._product.categoryId = value;
                    });
                  },
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'PRODUCT CODE'),
                initialValue: widget._product.productCode ?? '',
                validator: (value) {
                  return value.isEmpty ? 'Product code is blank.' : null;
                },
                onChanged: (value) {
                  widget._product.productCode = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child:  TextFormField(
                      decoration: InputDecoration(labelText: 'UNIT COST'),
                      initialValue: widget._product.unitCost == 0 ? '' : widget._product.unitCost.toString(),
                      inputFormatters:[ DecimalTextInputFormatter(decimalRange: 2) ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        return value.isEmpty ? 'Unit cost is blank.' : null;
                      },
                      onChanged: (value) {
                        widget._product.unitCost = double.parse(value);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: LabeledCheckbox(
                      label: 'VAT',
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      value: widget._product.vat == 1,
                      onChanged: (bool value) {
                        setState(() {
                          widget._product.vat = value ? 1 : 0;
                          widget._product.scVatExempt = 0;
                          widget._product.pwdVatExempt = 0;
                          widget._product.zeroRated = 0;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child:  TextFormField(
                      decoration: InputDecoration(labelText: 'UNIT PRICE'),
                      initialValue: widget._product.unitPrice == 0 ? '' : widget._product.unitPrice.toString(),
                      inputFormatters:[ DecimalTextInputFormatter(decimalRange: 2) ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        return value.isEmpty ? 'Unit price is blank.' : null;
                      },
                      onChanged: (value) {
                        widget._product.unitPrice = double.parse(value);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: LabeledCheckbox(
                      label: 'Non-VAT',
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      value: widget._product.nonVat == 1,
                      onChanged: (bool value) {
                        setState(() {
                          widget._product.nonVat = value ? 1 : 0;
                        });
                      },
                    ),
                  ),
                ],
              ),
              LabeledCheckbox(
                label: 'SC Discount',
                padding: EdgeInsets.symmetric(vertical: 10.0),
                value: widget._product.scDiscount == 1,
                onChanged: (bool value) {
                  setState(() {
                    widget._product.scDiscount = value ? 1 : 0;
                  });
                },
              ),
              LabeledCheckbox(
                label: 'PWD Discount',
                padding: EdgeInsets.symmetric(vertical: 10.0),
                value: widget._product.pwdDiscount == 1,
                onChanged: (bool value) {
                  setState(() {
                    widget._product.pwdDiscount = value ? 1 : 0;
                  });
                },
              ),
              LabeledCheckbox(
                label: 'Other Discount',
                padding: EdgeInsets.symmetric(vertical: 10.0),
                value: widget._product.otherDiscount == 1,
                onChanged: (bool value) {
                  setState(() {
                    widget._product.otherDiscount = value ? 1 : 0;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: RaisedButton(
                        child: Text('Cancel'),
                        color: Color(0xff6558f5),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: RaisedButton(
                      child: Text('OK'),
                      color: Color(0xff6558f5),
                      textColor: Colors.white,
                      onPressed: () {
                        _submit(context);
                      }
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}