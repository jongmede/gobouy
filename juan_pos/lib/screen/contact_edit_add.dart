import 'package:flutter/material.dart';
import 'package:juan_pos/database/contact.dart';
import 'package:juan_pos/database/database_helper.dart';

class ContactPageAdd extends StatefulWidget {

  final bool edit;
  final Contact editContact;

  ContactPageAdd(this.edit, this.editContact);

  @override
  ContactPageAddState createState() => ContactPageAddState();
}

class ContactPageAddState extends State<ContactPageAdd> {

  DatabaseHelper db = new DatabaseHelper();

  bool edit;
  Contact editContact;
  TextEditingController namec, addressc, tinc, busStylec, scidc, pdwidc;

  @override
  void initState() {
    edit = widget.edit;
    editContact = widget.editContact;
    namec = new TextEditingController(text: edit?editContact.contactName:null);
    addressc = new TextEditingController(text: edit?editContact.address:null);
    tinc = new TextEditingController(text: edit?editContact.tin:null);
    busStylec = new TextEditingController(text: edit?editContact.busStyle:null);
    scidc = new TextEditingController(text: edit?editContact.scId:null);
    pdwidc = new TextEditingController(text: edit?editContact.pwId:null);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> _contactFormKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: Text((edit?'Edit':'New')+' Contact'+scidc.text+pdwidc.text),

          actions: edit?<Widget>[
            Container(
              width: 100,
              alignment: Alignment.center,
              child: GestureDetector(
                child: Icon(Icons.delete,color: Colors.white,),
                onTap: (){
                  db.deleteContact(editContact);
                  Navigator.of(context).pop();
                },
              ),
            )
          ]:null,

        ),
        body: Builder(builder: (ctxt)=>
            Form(
              key: _contactFormKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'NAME'),
                      controller: namec,
                      onChanged: (value) {

                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'ADDRESS'),
                      controller: addressc,
                      onChanged: (value) {

                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'TIN'),
                      controller: tinc,
                      onChanged: (value) {

                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'BUSINESS STYLE'),
                      controller: busStylec,
                      onChanged: (value) {

                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'SC ID'),
                      controller: scidc,
                      onChanged: (value) {
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'PWD ID'),
                      controller: pdwidc,
                      onChanged: (value) {
                      },
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
                                child: Text('Add'),
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
        )
    );
  }

  submit(BuildContext ctxt) async{
    if(namec.text!=""){
      Contact contact = new Contact(
          contactId: edit?editContact.contactId:null,
          contactName: namec.text,
          address: addressc.text,
          tin: tinc.text,
          busStyle: busStylec.text,
          scId: scidc.text,
          pwId: pdwidc.text
      );
      edit?db.updateContact(contact):db.saveContact(contact);
      Scaffold.of(ctxt).showSnackBar(SnackBar(content: Text("Contact Added"),));
      Navigator.of(context).pop();
    }
    else{
      Scaffold.of(ctxt).showSnackBar(SnackBar(content: Text("Please fill are required fields!"),backgroundColor: Colors.red.shade900,));
    }
  }

}