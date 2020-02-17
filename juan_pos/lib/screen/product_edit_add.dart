import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juan_pos/comp/labeled_checkbox.dart';
import 'package:juan_pos/database/database_helper.dart';
import 'package:juan_pos/database/product.dart';

class AddProductPage extends StatefulWidget {

  final Product editProduct;
  final bool edit;

  AddProductPage(this.edit, this.editProduct);

  @override
  AddProductPageState createState() => AddProductPageState();
}

class AddProductPageState extends State<AddProductPage> {


  DatabaseHelper db = new DatabaseHelper();
  Product editProduct;
  bool edit;

  //Text Controllers
  TextEditingController namec,categoryc,codec,costc,pricec,pdwratec,otherratec,scratec;
  bool vat,scDiscount,pdwDiscount,otherDiscount,scVatExempt,pdwVatExempt,zeroRated;




  @override
  void initState() {
    edit = widget.edit;
    editProduct = widget.editProduct;
     namec = new TextEditingController(text: edit?editProduct.productName:null);
     categoryc = new TextEditingController();
     codec = new TextEditingController(text: edit?editProduct.productCode:null);
     costc = new TextEditingController(text: edit?editProduct.unitCost.toString():null);
     pricec = new TextEditingController(text: edit?editProduct.unitPrice.toString():null);
     pdwratec = new TextEditingController(text: edit?editProduct.pdwDiscountPercent.toString():null);
     scratec = new TextEditingController(text: edit?editProduct.scDiscountPercent.toString():null);
     otherratec = new TextEditingController(text: edit?editProduct.otherDiscountPercent.toString():null);
    //options
    vat = edit?(editProduct.vat==1?true:false):false;
    scDiscount = edit?(editProduct.scDiscount==1?true:false):false;
    pdwDiscount = edit?(editProduct.pdwDiscount==1?true:false):false;
    otherDiscount = edit?(editProduct.otherDiscount==1?true:false):false;
    scVatExempt = edit?(editProduct.scVatExempt==1?true:false):false;
    pdwVatExempt = edit?(editProduct.pdwVatExempt==1?true:false):false;
    zeroRated = edit?(editProduct.zeroRated==1?true:false):false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> _productFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text((edit?'Edit':'New')+' Product'),
        actions: edit?<Widget>[
          Container(
            width: 100,
            alignment: Alignment.center,
            child: GestureDetector(
              child: Icon(Icons.delete,color: Colors.white,),
              onTap: (){
                db.deleteProduct(editProduct);
                Navigator.of(context).pop();
              },
            ),
          )
        ]:null,
      ),
      body: Builder(builder: (ctxt) =>
          Form(
            key: _productFormKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'PRODUCT NAME'),
                    controller: namec,
                    onChanged: (value) {

                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'CATEGORY NAME'),
                    controller: categoryc,
                    onChanged: (value) {

                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'PRODUCT CODE'),
                    controller: codec,
                    onChanged: (value) {

                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'UNIT PRICE'),
                          keyboardType: TextInputType.number,
                          controller: pricec,
                          onChanged: (value) {
                          },
                        ),
                      ),

                      SizedBox(width: 10),

                      Flexible(
                        flex: 2,
                        child:  TextFormField(
                          decoration: InputDecoration(labelText: 'UNIT COST'),
                          keyboardType: TextInputType.number,
                          controller: costc,
                          onChanged: (value) {

                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),


                  Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("TAX INFO", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 15),),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("NV",style: TextStyle(color: vat?Colors.grey:Colors.teal,fontSize: 15),),
                            SizedBox(width: 5,),
                            Container(
                              width: 100,
                              child: Switch(
                                value: vat,
                                onChanged: (value){
                                  setState(() {
                                    vat = value;
                                    scVatExempt=false;
                                    pdwVatExempt=false;
                                    zeroRated=false;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text("VAT",style: TextStyle(color: !vat?Colors.grey:Colors.teal,fontSize: 15),),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LabeledCheckbox(
                          label: vat?'SC VAT Exempt':'--',
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          value: scVatExempt,
                          onChanged: vat?(bool value) {
                            setState(() {
                              scVatExempt = value;
                            });
                          }:null,
                        ),
                      ),

                      Expanded(
                        child: LabeledCheckbox(
                          label: vat?'PDW Exempt':'--',
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          value: pdwVatExempt,
                          onChanged: vat?(bool value) {
                            setState(() {
                              pdwVatExempt = value;
                            });
                          }:null,
                        ),
                      ),

                      Expanded(
                        child: LabeledCheckbox(
                          label: vat?'Zero-Rated':'--',
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          value: zeroRated,
                          onChanged: vat?(bool value) {
                            setState(() {
                              zeroRated = value;
                            });
                          }:null,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("DISCOUNT", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 15),),
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: LabeledCheckbox(
                          label: 'SC',
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          value: scDiscount,
                          onChanged: (bool value) {
                            setState(() {
                              scDiscount = value;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        flex: 7,
                        child: getTextField("0.00%", scratec,scDiscount),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: LabeledCheckbox(
                          label: 'PDW',
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          value: pdwDiscount,
                          onChanged: (bool value) {
                            setState(() {
                              pdwDiscount = value;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        flex: 7,
                        child: getTextField("0.00%", pdwratec,pdwDiscount),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: LabeledCheckbox(
                          label: 'OTHER',
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          value: otherDiscount,
                          onChanged: (bool value) {
                            setState(() {
                              otherDiscount = value;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        flex: 7,
                        child: getTextField("0.00%", otherratec,otherDiscount),
                      )
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: RaisedButton(
                              child: Text('Ok'),
                              color: Color(0xff6558f5),
                              textColor: Colors.white,
                              onPressed: () {
                                submit(ctxt);
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),


    );
  }



//methods
  submit(BuildContext ctxt) async{

    if(namec.text!="" && categoryc.text!="" && codec.text!="" && pricec.text!="" && costc.text!=""){
      Product p = new Product(
        productId: edit?editProduct.productId:null,
        productName: namec.text,
        productCode: codec.text,
        unitPrice: double.parse(pricec.text),
        unitCost: double.parse(costc.text),
        vat: (vat?1:0),
        nVat: (!vat?1:0),
        scDiscount: (scDiscount?1:0),
        pdwDiscount: (pdwDiscount?1:0),
        otherDiscount: (otherDiscount?1:0),
        scVatExempt: (scVatExempt?1:0),
        pdwVatExempt: (pdwVatExempt?1:0),
        zeroRated: (zeroRated?1:0),
        scDiscountPercent: (scDiscount&&scratec.text!=""?double.parse(scratec.text)/100:0),
        otherDiscountPercent: (otherDiscount&&otherratec.text!=""?double.parse(otherratec.text)/100:0),
        pdwDiscountPercent: (pdwDiscount&&pdwratec.text!=""?double.parse(pdwratec.text)/100:0),
      );

      if(edit){
        await db.updateProduct(p);
      }
      else{
        await db.saveProduct(p);
      }

      Scaffold.of(ctxt).showSnackBar(new SnackBar(content: Text("Product added!")));
      Navigator.of(ctxt).pop();
    }
    else{
      Scaffold.of(ctxt).showSnackBar(SnackBar(content: Text("Please fill required fields!"),backgroundColor: Colors.red.shade900,));
    }

  }

  Widget getTextField(String hint,TextEditingController controller,bool enable){
    return enable?TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: '0.00',
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300,width: 2),borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.only(left: 20),
      ),
      keyboardType: TextInputType.numberWithOptions(signed: false),
    ):

    TextFormField(
      focusNode: new AlwaysDisabledFocusNode(),
      decoration: InputDecoration(
        hintText: "disabled",
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300,width: 2),borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.only(left: 20),
      ),
      keyboardType: TextInputType.numberWithOptions(signed: false),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode{
  @override
  bool get hasFocus => false;
}