import 'package:flutter/material.dart';
import 'package:juan_pos/database/product.dart';
import 'package:juan_pos/database/database_helper.dart';
import 'package:juan_pos/database/sales_invoice.dart';
import 'package:juan_pos/database/tender.dart';
import 'package:juan_pos/database/transaction.dart';

class SalesInvoiceReceipt extends StatefulWidget {

  final SalesInvoice si;
  SalesInvoiceReceipt(this.si);

  @override
  SalesInvoiceReceiptState createState() => SalesInvoiceReceiptState();
}

class SalesInvoiceReceiptState extends State<SalesInvoiceReceipt> {

  DatabaseHelper db = new DatabaseHelper();
  Map<int,Product> productById = new Map<int,Product>();
  Map<int,Tender> tenderById = new Map<int,Tender>();


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getDataBundle(),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {

        if(snapshot.hasData){
          List<Product> products = snapshot.data["products"];
          List<Tender> tenders = snapshot.data["tenders"];
          products.forEach((product){
            productById[product.productId] = product;
          });
          tenders.forEach((tender){
            tenderById[tender.tenderId] = tender;
          });
        }

        return snapshot.hasData?Container(
          width: (MediaQuery.of(context).size.width/1.6),
          height: (MediaQuery.of(context).size.height/1.6),
          color: Colors.white,
          child: SingleChildScrollView( child: Column(
            children: <Widget>[
              Container(
                child: Text("Sales Invoice No: "+ widget.si.getNumber().toString()),
              ),
              Divider(),
              Table(
                children: getItemRows(widget.si.transactions),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("No. of Items: "+getItemNo(widget.si.transactions).toString()),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(""),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Total Amount:"),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(getItemTotal(widget.si.transactions).toString()),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Tender Amount:"),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("--"),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Change Amount:"),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("--"),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Vatable Sales:"),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(getVatableSales().toString()),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Vat Amount:"),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(getVatAmt().toString()),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Non-VAT Sales:"),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(getNonVatableSales().toString()),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("VAT Exempt Sales:"),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(getExemptSales().toString()),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Zero-Rated Sales:"),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(getZeroRatedSales().toString()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )):Center(child: Icon(Icons.blur_circular),);
      },
    );
  }

  List<TableRow> getItemRows(List<Transaction> tlist){
    List<TableRow> rows = new List();

    rows.add(
      TableRow(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text('Item',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text('Quantity',
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
        ]
      )
    );

    tlist.forEach((t){
      Product p = productById[t.productId];
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(p.productName,
                style: TextStyle(
                    fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(t.qty.toString(),
                style: TextStyle(
                    fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text((t.unitPrice*t.qty-t.otherDiscountAmt-t.scDiscountAmt-t.pdwDiscountAmt).toString(),
                style: TextStyle(
                    fontSize: 16,
                ),
              ),
            ),
          ]
        )
      );
    });

    return rows;
  }


  Future<Map> getDataBundle() async{
    List<Product> products = await db.getProduct();
    List<Tender> tenders = await db.getTender();
    Map map = new Map();
    map["products"] = products;
    map["tenders"] = tenders;

    return map;
  }

  int getItemNo(List<Transaction> list){
    int total = 0;
    list.forEach((t){
      total = total + t.qty.round();
    });
    return total;
  }

  double getItemTotal(List<Transaction> list){
    double total = 0;
    list.forEach((t){
      total = total + (t.qty*t.unitPrice-t.pdwDiscountAmt-t.scDiscountAmt-t.otherDiscountAmt);
    });
    return total;
  }

  double getVatableSales(){
    double total = 0;
    widget.si.transactions.forEach((t){
      total = total + (t.vatableSales/1.12);
    });
    return total.roundToDouble();
  }
  double getVatAmt(){
    double total = 0;
    widget.si.transactions.forEach((t){
      total = total + (t.vatAmt);
    });
    return total.roundToDouble();
  }
  double getNonVatableSales(){
    double total = 0;
    widget.si.transactions.forEach((t){
      total = total + t.nonVatSales;
    });
    return total.roundToDouble();
  }
  double getZeroRatedSales(){
    double total = 0;
    widget.si.transactions.forEach((t){
      total = total + t.zeroRatedSales;
    });
    return total.roundToDouble();
  }
  double getExemptSales(){
    double total = 0;
    widget.si.transactions.forEach((t){
      total = total + t.vatExemptSales;
    });
    return total.roundToDouble();
  }

}