import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juan_pos/database/database_helper.dart';
import 'package:juan_pos/database/transaction.dart';
import 'package:juan_pos/database/tender.dart';

class PaymentPage extends StatefulWidget {

  final List<Transaction> transactions;

  PaymentPage(this.transactions);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {

  final int CREDIT_CARD_VISA = 1;
  final int CREDIT_CARD_MASTERCARD = 2;

  // 1 - cash, 2 - credit card.
  int paymentChosen = 1;
  int creditCardType = 1;

  double receivedAmount;
  DatabaseHelper db = new DatabaseHelper();

  int cardNum,refNum;
  String cardName, approvalCode;

  List<Widget> _getCashWidgets() {
    return [
      TextFormField(
        decoration: InputDecoration(
          hintText: "Enter Received Amount",
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300,width: 2),borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.only(left: 20),
        ),
        keyboardType: TextInputType.numberWithOptions(signed: false),
        onChanged: (value) {
          setState(() {
            receivedAmount = double.parse(value);
          });
        },
      ),

      SizedBox(height: 10,),

      getTextBox("TOTAL AMOUNT : "+getTotal().toString()),

      SizedBox(height: 10,),

      getTextBox("CHANGE AMOUNT : "+(receivedAmount!=null?(receivedAmount-getTotal()).toString():"--")),

      SizedBox(height: 10,),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text('VATABLE Sales'),
          ),
          Flexible(
            flex: 2,
            child: getTextBox(getVatableSales().toString()),
          ),
        ],
      ),
      SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text('VAT Amount'),
          ),
          Flexible(
            flex: 2,
            child:   getTextBox(getVatAmt().toString()),

          ),
        ],
      ),
      SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text('Non-VAT Sales'),
          ),
          Flexible(
            flex: 2,
            child: getTextBox(getNonVatableSales().toString()),
          ),
        ],
      ),
      SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text('VAT-Exempt Sales'),
          ),
          Flexible(
            flex: 2,
            child: getTextBox(getExemptSales().toString()),
          ),
        ],
      ),
      SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text("Zero-Rated Sales"),
          ),
          Flexible(
            flex: 2,
            child: getTextBox(getZeroRatedSales().toString()),
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
          setState(() {
            cardName = value;
          });
        },
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'XXXX-XXXX-XXXX-12345'),
        keyboardType: TextInputType.numberWithOptions(signed: false,decimal: false),
        onChanged: (value) {
          setState(() {
            cardNum = int.parse(value);
          });
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
                setState(() {
                  approvalCode = value;
                });
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
              keyboardType: TextInputType.numberWithOptions(signed: false,decimal: false),
              decoration: InputDecoration(hintText: '123443434'),
              onChanged: (value) {
                setState(() {
                  refNum = int.parse(value);
                });
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
                        Navigator.of(context).pop();
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
                      if(paymentChosen==1){
                        submitTransactions();
                      }
                      if(paymentChosen==1&&cardName!=null&&cardNum!=null&&approvalCode!=null&&refNum!=null){
                        submitTransactions();
                      }
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


  //methods
  Widget getTextBox(String value){
    return Container(
      constraints: BoxConstraints.expand(height: 50),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300,width: 2)
      ),
      child: Text(value,style: TextStyle(color: Colors.grey.shade400,fontSize: 16,fontWeight: FontWeight.bold),),
    );
  }

  double getTotal(){
    double total = 0;
    widget.transactions.forEach((t){
      double tTotal = (t.unitPrice*t.qty)-(t.otherDiscountAmt+t.scDiscountAmt+t.pdwDiscountAmt);
      total = total +tTotal;
    });
    return total.roundToDouble();
  }
  double getVatableSales(){
    double total = 0;
    widget.transactions.forEach((t){
      total = total + (t.vatableSales/1.12);
    });
    return total.roundToDouble();
  }
  double getVatAmt(){
    double total = 0;
    widget.transactions.forEach((t){
      total = total + (t.vatAmt);
    });
    return total.roundToDouble();
  }
  double getNonVatableSales(){
    double total = 0;
    widget.transactions.forEach((t){
      total = total + t.nonVatSales;
    });
    return total.roundToDouble();
  }
  double getZeroRatedSales(){
    double total = 0;
    widget.transactions.forEach((t){
      total = total + t.zeroRatedSales;
    });
    return total.roundToDouble();
  }
  double getExemptSales(){
    double total = 0;
    widget.transactions.forEach((t){
      total = total + t.vatExemptSales;
    });
    return total.roundToDouble();
  }

  submitTransactions(){
    widget.transactions.forEach(
        (t){
          Tender tender = new Tender(
            cashPay: paymentChosen==1?1:0,
            cardPay: paymentChosen==2?1:0,
            cardType: paymentChosen==2?creditCardType:0,
            cardNum: cardNum,
            transactionRefId: refNum,
            contactId: t.customerId,
            //userId
            approvalCode: approvalCode,
            amount: getTotal()
          );
          db.saveTransaction(t);
          db.saveTender(tender);
        }
    );
    Navigator.of(context).pop();
  }
}