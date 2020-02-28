import 'package:flutter/material.dart';
import 'package:juan_pos/database/database_helper.dart';
import 'package:juan_pos/model/product.dart';

class SearchBarcodePage extends StatefulWidget {

  final Function(Product) callback;

  SearchBarcodePage(this.callback);

  @override
  SearchBarcodePageState createState() => SearchBarcodePageState();
}

class SearchBarcodePageState extends State<SearchBarcodePage> {

  DatabaseHelper db = new DatabaseHelper();
  TextEditingController searchc = new TextEditingController();

  @override
  void initState() {

    searchc.addListener((){
      setState(() {
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.height/1.6),
      color: Colors.white,
      child: FutureBuilder(
        future: db.getProducts(),
        builder: (BuildContext context,AsyncSnapshot<List<Product>> snapshot){
          return snapshot.hasData?Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: 'Search code / id / name'),
                controller: searchc,
                onChanged: (value) {

                },
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(1),
                  },
                  children: getProductRows(filter(snapshot.data)),
                ),
              ),
            ],
          ):Center(child: Text("No Products Found."),);
        },
      )
    );
  }


  //methods

  List<Product> filter(List<Product> input){
    List<Product> output = new List<Product>();
    input.forEach((product){
      if(product.productId.toString()==searchc.text || product.productName.toLowerCase().contains(searchc.text.toLowerCase())){
        output.add(product);
      }
    });
    return output;
  }

  List<TableRow> getProductRows(List<Product> products){
    List<TableRow> rows = new List<TableRow>();

    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.all(10),
        child: Text('Id',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: Text("Product",
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
      Text(''),
    ]));

    products.forEach((product){
      rows.add(
      TableRow(children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(product.productId.toString()),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(product.productName),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(product.unitPrice.toString()),
        ),
        GestureDetector(
          onTap: (){
            widget.callback(product);
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.add),
          ),
        ),

      ]));
    });

    return rows;
  }
}