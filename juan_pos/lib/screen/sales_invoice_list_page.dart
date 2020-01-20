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
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('SI#',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Customer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(''),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(''),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(''),
              ),
            ])
          ],
        ),
      )
    );
  }

}