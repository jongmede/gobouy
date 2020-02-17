import 'package:flutter/material.dart';
import 'package:juan_pos/database/contact.dart';
import 'package:juan_pos/database/database_helper.dart';
import 'contact_edit_add.dart';

class ContactPage extends StatefulWidget {
  @override
  ContactPageState createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {

  DatabaseHelper db = new DatabaseHelper();
  TextEditingController searchc = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),

      body: FutureBuilder(
        future: db.getContact(),
        builder: (BuildContext ctxt,AsyncSnapshot<List<Contact>> snapshot){


          return snapshot.hasData&&snapshot.data.isNotEmpty?
          Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[

                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search Name / Id",
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300,width: 2),borderRadius: BorderRadius.circular(5)),
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                    controller: searchc,
                    onChanged: (value){
                      setState(() {
                      });
                    },
                  ),

                  SizedBox(height: 20,),

                  SingleChildScrollView(
                    child: Table(
                      columnWidths: {
                        0 : FlexColumnWidth(1),
                        1 : FlexColumnWidth(2),
                        2 : FlexColumnWidth(2),
                        3 : FlexColumnWidth(1.25),
                        4 : FlexColumnWidth(1),

                      },
                      border: TableBorder.all(color: Colors.grey.shade300,width: 2),
                      children: getTableRows(filter(snapshot.data)),
                    ),
                  )
                ],
              )
          ):
          Center(child: Text("No Contacts Found."),);
        },
      ),

      /*;*/

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: Colors.white,),
          backgroundColor: Color(0xff6558f5),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPageAdd(false,null)));
          }
      ),
    );
  }


  //methods

  List<TableRow> getTableRows(List<Contact> contacts){
    List<TableRow> rows = new List<TableRow>();

    rows.add(
        TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("ID",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("Contact",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("SCID",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("PWD ID",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("EDIT",style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ]
        )
    );

    contacts.forEach((c){
      rows.add(
          TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(c.contactId.toString()),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(c.contactName),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(c.scId),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(c.pwId),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: IconButton(icon: Icon(Icons.edit),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPageAdd(true,c)));
                        }
                    )
                ),
              ]
          )
      );
    });

    return rows;
  }

  List<Contact> filter(List<Contact> input){

    List<Contact> output = new List<Contact>();
    input.forEach((c){
      if(c.contactName.toLowerCase().contains(searchc.text.toLowerCase())||c.contactId.toString()==searchc.text){
        output.add(c);
      }
    });
    return output;
  }

}