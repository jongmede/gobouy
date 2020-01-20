import 'package:flutter/material.dart';

class CreditCardPage extends StatefulWidget {
  @override
  CreditCardPageState createState() => CreditCardPageState();
}

class CreditCardPageState extends State<CreditCardPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
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
                  title: Text('Visa'),
                  value: 1,
                  onChanged: (value) {

                  },
                ),
              ),
              Flexible(
                flex: 1,
                child:  RadioListTile(
                  activeColor: Theme.of(context).primaryColor,
                  title: Text('MasterCard'),
                  value: 2,
                  onChanged: (value) {

                  },
                ),
              ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'NAME'),
            onChanged: (value) {

            },
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'XXXX-XXXX-XXXX-12345'),
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
    );
  }

}