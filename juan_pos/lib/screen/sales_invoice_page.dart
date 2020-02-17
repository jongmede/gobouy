
import 'package:flutter/material.dart';
import 'package:juan_pos/database/contact.dart';
import 'package:juan_pos/database/database_helper.dart';
import 'package:juan_pos/database/product.dart';
import 'package:juan_pos/screen/search_barcode_page.dart';
import 'payment_page.dart';
import 'select_contact_page.dart';
import 'package:juan_pos/database/transaction.dart';

class SalesInvoicePage extends StatefulWidget {
  @override
  SalesInvoicePageState createState() => SalesInvoicePageState();
}

class SalesInvoicePageState extends State<SalesInvoicePage> {

  DateTime dateTime = DateTime.now();
  final months = ["Jan","Feb","Mar","Apr","May","Jun","July","Sept","Oct","Nov","Dec"];

  DatabaseHelper db = new DatabaseHelper();
  String customerName = "Click here to add +";
  Contact selectedCustomer;
  Map<int,int> cart = new Map<int,int>();
  Map<int,double> otherDiscountMap = new Map<int,double>();
  Map<int,Product> productById = new Map<int,Product>();
  Map<int,TextEditingController> quantityControllers = new Map<int,TextEditingController>();

  //discounts
  bool scApplied = false;
  bool pdwApplied = false;
  bool otherApplied = false;

  int invoiceNum;

  cartCallback(Product product){
    setState(() {
      if(cart.containsKey(product.productId)){
        cart[product.productId] = cart[product.productId]+1;
      }
      else{
        cart[product.productId] = 1;
      }
    });
  }

  customerCallback(Contact selected){
    setState(() {
      selectedCustomer = selected;
      customerName = selectedCustomer.contactName;
    });
  }

  @override
  void initState() {
    updateProductsById();
    getInvoiceNumber();
    super.initState();
  }

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
                          child: Text('Date time: '+months[dateTime.month-1]+" "+dateTime.day.toString()+", "+dateTime.year.toString()+" "+dateTime.hour.toString()+":"+dateTime.minute.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('Sales Invoice: '+invoiceNum.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: <Widget>[
                              Text('Customer Name: ',
                                style: TextStyle(fontSize: 16),
                              ),
                              GestureDetector(
                                child: Text(customerName,
                                  style: TextStyle(fontSize: 16,color: Colors.teal,fontWeight: FontWeight.bold),
                                ),

                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        content: SelectContactPage(customerCallback),
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          )
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.strikethrough_s,
                                color: !otherApplied?Colors.grey:Colors.teal,
                              ),
                              onPressed: () {
                                setState(() {
                                  otherApplied = !otherApplied;
                                  scApplied = false;
                                  pdwApplied = false;
                                });
                              },
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: !otherApplied?Colors.grey:Colors.teal,
                                width: 1, //                   <--- border width here
                              ),
                            )
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.accessible,
                                color: !pdwApplied?Colors.grey:Colors.teal,
                              ),
                              onPressed: () {
                                setState(() {
                                  otherApplied = false;
                                  scApplied = false;
                                  pdwApplied = !pdwApplied;
                                });
                              },
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: !pdwApplied?Colors.grey:Colors.teal,
                                width: 1, //                   <--- border width here
                              ),
                            )
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.airline_seat_recline_normal,
                                color: !scApplied?Colors.grey:Colors.teal,
                              ),
                              onPressed: () {
                                setState(() {
                                  otherApplied = false;
                                  scApplied = !scApplied;
                                  pdwApplied = false;
                                });
                              },
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: !scApplied?Colors.grey:Colors.teal,
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
                                      content: SearchBarcodePage(cartCallback),
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
                          border: TableBorder.all(color: Colors.grey),
                          columnWidths: {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                            3: FlexColumnWidth(1),
                            4: FlexColumnWidth(1),
                          },
                          children: getCartRows(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Text('No. of Items: '+getItems().toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text('Total: '+getTotal().toString(),
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
                                  Navigator.of(context).pop();
                                }
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: RaisedButton(
                              child: Text(cart.isNotEmpty?'Pay':'Cart is Empty'),
                              color: Color(0xff6558f5),
                              textColor: Colors.white,
                              onPressed: cart.isNotEmpty&&selectedCustomer!=null?(() {
                                proceedToPay();
                              }):null,
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


  //methods

  updateProductsById() async{
    List<Product> products = await db.getProduct();
    products.forEach((product){
      productById[product.productId] = product;
    });
  }

  List<TableRow> getCartRows(){
    List<TableRow> rows = new List<TableRow>();
    rows.add(
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
          child: Text('% Dsc',
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
      ]),);


    cart.forEach((int id,int quantity){
      Product product = productById[id];
      rows.add(
        TableRow(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: Text(product.productName,
              style: TextStyle(
                  fontSize: 16,
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: !otherApplied?Text((pdwApplied?productById[id].pdwDiscountPercent*100:productById[id].scDiscountPercent*100).toString(),
              style: TextStyle(
                fontSize: 16,
              ),
            ):
            TextField(
              decoration: InputDecoration(
                isDense: true,
              ),
              onChanged: (value){
                setState(() {
                  otherDiscountMap[id] = double.parse(value);
                });
              },
            )
            ,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: Text(product.unitPrice.toString(),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: quantity.toString(),
              decoration: InputDecoration(
                isDense: true,
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: false,signed: false),
              onChanged: (value){
                setState(() {
                  cart[id] = int.parse(value);
                  if(int.parse(value)==0){
                    cart.remove(id);
                  }
                });
              },
            )
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: Text((product.unitPrice*quantity-getItemDiscount(id, quantity)).floor().toString(),
              style: TextStyle(
                  fontSize: 16,
              ),
            ),
          ),
        ]));
    });

    return rows;
  }

  getTotal(){
    double total = 0;
    cart.forEach((id,quantity){
      total = total + productById[id].unitPrice*quantity - getItemDiscount(id, quantity);
    });
    return total;
  }

  getItems(){
    int total = 0;
    cart.forEach((id,quantity){
      total = total + quantity;
    });
    return total;
  }

  double getItemDiscount(int id, quantity){
    double discount = 0;
    Product p = productById[id];
    if(scApplied){
      discount = (p.unitPrice*quantity)*p.scDiscountPercent;
    }
    if(pdwApplied){
      discount = (p.unitPrice*quantity)*p.pdwDiscountPercent;
    }

    if(otherApplied){
      discount = otherDiscountMap[id]!=null?(p.unitPrice*quantity*otherDiscountMap[id]/100):0;
    }
    return discount;
  }

  proceedToPay(){
    List<Transaction> transactions = new List<Transaction>();
    cart.forEach((id,quantity){
      Product product = productById[id];
      transactions.add(new Transaction(
        taxType: product.vat==1?"vat":"nVat",
        productId: id,
        customerId: selectedCustomer.contactId,
        qty: quantity.toDouble(),
        unitPrice: product.unitPrice,
        scDiscountAmt: product.scDiscount==1&&scApplied?(product.scDiscountPercent*quantity*product.unitPrice):0,
        pdwDiscountAmt: product.scDiscount==1&&pdwApplied?(product.pdwDiscountPercent*quantity*product.unitPrice):0,
        otherDiscountAmt: product.scDiscount==1&&otherApplied?(product.otherDiscountPercent*quantity*product.unitPrice):0,
        nonVatSales: product.nVat==1?(product.unitPrice*quantity):0,
        vatableSales: product.vat==1?(getUnitVatableSales(product,quantity)):0,
        vatAmt: product.vat==1?(getUnitVatableSales(product,quantity)*0.12):0,
        //uncertain fields
        number: invoiceNum,
        vatExemptSales: (product.scVatExempt==1||product.pdwVatExempt==1)?(product.unitPrice*quantity):0,
        zeroRatedSales: product.zeroRated==1?(product.unitPrice*quantity):0,
      ));
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(transactions)));
  }

  double getUnitVatableSales(Product p,int qty){
    double sales = 0;
    if(p.vat==1&&p.zeroRated==0&&p.pdwVatExempt==0&&p.scVatExempt==0){
      sales = p.unitPrice*qty;
    }
    return sales;
  }

  getInvoiceNumber() async{
    int number;
    List<Transaction> oldlist = await db.getTransaction();
    if(oldlist.isEmpty){
      number= 0;
    }
    else{
      number = oldlist.last.number + 1;
    }
    setState(() {
      invoiceNum = number;
    });
  }
}