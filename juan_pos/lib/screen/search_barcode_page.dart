import 'package:flutter/material.dart';

class SearchBarcodePage extends StatefulWidget {
  @override
  SearchBarcodePageState createState() => SearchBarcodePageState();
}

class SearchBarcodePageState extends State<SearchBarcodePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(hintText: 'Search Barcode'),
            onChanged: (value) {

            },
          ),
          Table(
            border: TableBorder.all(color: Colors.black),
            children: [
              TableRow(children: [
                Text('Product',),
                Text('Price'),
                Text(''),
              ]),
              TableRow(children: [
                Text('PriceChippy @ 25.00'),
                Text('25.00'),
                Text(''),
              ])
            ],
          ),
        ],
      ),
    );
  }

}