import 'package:flutter/material.dart';
import 'package:juan_pos/screen/search_barcode_page.dart';

import 'payment_page.dart';

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
      body: LayoutBuilder(
        // This is used so that we can max the height of the table using extra space.
        builder: (context, constraint) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(15),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.code,
                                color: Color.fromRGBO(26, 174, 159, 1),
                              ),
                              onPressed: () {

                              },
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(26, 174, 159, 1),
                                width: 1, //                   <--- border width here
                              ),
                            )
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.accessible,
                                color: Color.fromRGBO(26, 174, 159, 1),
                              ),
                              onPressed: () {

                              },
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(26, 174, 159, 1),
                                width: 1, //                   <--- border width here
                              ),
                            )
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.airline_seat_recline_normal,
                                color: Color.fromRGBO(26, 174, 159, 1),
                              ),
                              onPressed: () {

                              },
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(26, 174, 159, 1),
                                width: 1, //                   <--- border width here
                              ),
                            )
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.add_box,
                                color: Color.fromRGBO(26, 174, 159, 1),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      content: SearchBarcodePage(),
                                    );
                                  },
                                );
                              },
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(26, 174, 159, 1),
                                width: 1, //                   <--- border width here
                              ),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child:Table(
                          border: TableBorder.all(color: Colors.black),
                          columnWidths: {
                            0: FlexColumnWidth(3),
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
                                child: Text('QTY',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text('Total',
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
                                child: Text('PriceChippy @ 25.00'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text('2'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text('50V'),
                              )
                            ]),
                          ],
                        ),
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
                              child: Text('Pay'),
                              color: Color(0xff6558f5),
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
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
        },
      )
    );
  }

}