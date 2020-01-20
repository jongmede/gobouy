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
          SizedBox(height: 20),
          Table(
            border: TableBorder.all(color: Colors.black),
            columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
            },
            children: [
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Product',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Price',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(''),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('PriceChippy @ 25.00'),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('25.00'),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(''),
                ),
              ])
            ],
          ),
        ],
      ),
    );
  }

}