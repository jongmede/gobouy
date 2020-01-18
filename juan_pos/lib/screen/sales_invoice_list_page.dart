import 'package:flutter/material.dart';

class SalesInvoiceListPage extends StatefulWidget {
  @override
  SalesInvoiceListPageState createState() => SalesInvoiceListPageState();
}

class SalesInvoiceListPageState extends State<SalesInvoiceListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Invoice'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [
              Text('Cell 1',),
              Text('Cell 2'),
              Text('Cell 3'),
            ]),
            TableRow(children: [
              Text('Cell 4'),
              Text('Cell 5'),
              Text('Cell 6'),
            ])
          ],
        ),
      )
    );
  }

}