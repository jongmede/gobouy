import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {

  final int CREDIT_CARD_VISA = 1;
  final int CREDIT_CARD_MASTERCARD = 2;

  // 1 - cash, 2 credit card.
  int paymentChosen = 1;
  int creditCardType = 1;

  List<Widget> _getCashWidgets() {
    return [
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
    ];
  }

  List<Widget> _getCreditCardWidgets() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: RadioListTile(
              activeColor: Theme.of(context).primaryColor,
              groupValue: creditCardType,
              title: Text('Visa'),
              value: 1,
              onChanged: (value) {
                setState(() {
                  creditCardType = value;
                });
              },
            ),
          ),
          Flexible(
            flex: 1,
            child:  RadioListTile(
              activeColor: Theme.of(context).primaryColor,
              groupValue: creditCardType,
              title: Text('MasterCard'),
              value: 2,
              onChanged: (value) {
                setState(() {
                  creditCardType = value;
                });
              },
            ),
          ),
        ],
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'NAME'),
        onChanged: (value) {

        },
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'XXXX-XXXX-XXXX-12345'),
        onChanged: (value) {

        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text('APPROVAL CODE'),
          ),
          Flexible(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(hintText: '2323DR'),
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
            child: Text('Ref. No.'),
          ),
          Flexible(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(hintText: '123443434'),
              onChanged: (value) {

              },
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _getWidgets() {
    return paymentChosen == 1 ? _getCashWidgets() : _getCreditCardWidgets();
  }

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
                    activeColor: Theme.of(context).primaryColor,
                    groupValue: paymentChosen,
                    title: Text('Cash'),
                    value: 1,
                    onChanged: (value) {
                      setState(() {
                        paymentChosen = value;
                      });
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child:  RadioListTile(
                    activeColor: Theme.of(context).primaryColor,
                    groupValue: paymentChosen,
                    title: Text('Credit Card'),
                    value: 2,
                    onChanged: (value) {
                      setState(() {
                        paymentChosen = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            ... _getWidgets(),
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
      )
    );
  }

}