import 'package:flutter/material.dart';
import 'package:juan_pos/comp/labeled_checkbox.dart';

class ProductPage extends StatefulWidget {
  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> _productFormKey = GlobalKey<FormState>();

    return Scaffold(
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
                onChanged: (value) {

                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'CATEGORY NAME'),
                onChanged: (value) {

                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'PRODUCT CODE'),
                onChanged: (value) {

                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: LabeledCheckbox(
                      label: 'VAT',
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      value: false,
                      onChanged: (bool value) {

                      },
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child:  TextFormField(
                      decoration: InputDecoration(labelText: 'UNIT COST'),
                      onChanged: (value) {

                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Flexible(
                    flex: 2,
                    child:  TextFormField(
                      decoration: InputDecoration(labelText: 'UNIT PRICE'),
                      onChanged: (value) {

                      },
                    ),
                  ),
                ],
              ),
              LabeledCheckbox(
                label: 'SC Discount',
                padding: EdgeInsets.symmetric(vertical: 10.0),
                value: false,
                onChanged: (bool value) {

                },
              ),
              LabeledCheckbox(
                label: 'SC Discount',
                padding: EdgeInsets.symmetric(vertical: 10.0),
                value: false,
                onChanged: (bool value) {

                },
              ),
              LabeledCheckbox(
                label: 'PDW Discount',
                padding: EdgeInsets.symmetric(vertical: 10.0),
                value: false,
                onChanged: (bool value) {

                },
              ),
              LabeledCheckbox(
                label: 'Other Discount',
                padding: EdgeInsets.symmetric(vertical: 10.0),
                value: false,
                onChanged: (bool value) {

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