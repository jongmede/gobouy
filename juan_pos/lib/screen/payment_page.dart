import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: RadioListTile(
                    title: Text('Cash'),
                    onChanged: (value) {

                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child:  RadioListTile(
                    title: Text('Credit Card'),
                    onChanged: (value) {

                    },
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter Amount Received'),
              onChanged: (value) {

              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'TOTAL AMOUNT'),
              onChanged: (value) {

              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'CHANGE AMOUNT'),
              onChanged: (value) {

              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Text('VATABLE Sales'),
                ),
                Flexible(
                  flex: 2,
                  child:  TextFormField(
                    decoration: InputDecoration(labelText: '000.00'),
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
                  child: Text('VATABLE Sales'),
                ),
                Flexible(
                  flex: 2,
                  child:  TextFormField(
                    decoration: InputDecoration(labelText: '000.00'),
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
                  child: Text('VAT Amount'),
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(hintText: '000.00'),
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
                  child: Text('Non-VAT Sales'),
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(hintText: '000.00'),
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
                  child: Text('VAT Exempt Sales'),
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(hintText: '000.00'),
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
                  child: Text('Zero Rated Sales'),
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(hintText: '000.00'),
                    onChanged: (value) {

                    },
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
                      child: Text('Cancel'),
                      onPressed: () {

                      }
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: RaisedButton(
                    child: Text('OK'),
                    onPressed: () {

                    }
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

}