import 'package:flutter/material.dart';

class SalesInvoicePage extends StatefulWidget {
  @override
  SalesInvoicePageState createState() => SalesInvoicePageState();
}

class SalesInvoicePageState extends State<SalesInvoicePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Invoice'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text('Date time: Jan 1, 2020 9:00AM',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text('Sales Invoice: 0000000000000000001',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text('Customer Name: John Pula',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {

                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {

                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {

                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {

                      },
                    ),
                  ],
                ),
                Table(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Text('No. of Items: 33',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text('Total: 21,300.00',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: RaisedButton(
                            child: Text('Exit'),
                            onPressed: () {

                            }
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: RaisedButton(
                          child: Text('Pay'),
                          onPressed: () {

                          }
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}