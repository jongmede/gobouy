import 'package:flutter/material.dart';
import 'package:juan_pos/database/contact.dart';
import 'package:juan_pos/database/database_helper.dart';

class SelectContactPage extends StatefulWidget {

  final Function(Contact) callback;

  SelectContactPage(this.callback);

  @override
  SelectContactPageState createState() => SelectContactPageState();
}

class SelectContactPageState extends State<SelectContactPage> {

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
      child: FutureBuilder(
        future: db.getContact(),
        builder: (BuildContext context,AsyncSnapshot<List<Contact>> snapshot){
          return snapshot.hasData?getContactSelector(filter(snapshot.data),widget.callback):Center(child: Text("No Contacts Found."));
        },
      ),
    );
  }


  //methods

  List<Contact> filter(List<Contact> input){
    List<Contact> output = new List<Contact>();
    input.forEach((contact){
      if((contact.contactName.toLowerCase().contains(searchc.text.toLowerCase()))|(contact.contactId.toString()==searchc.text)){
        output.add(contact);
      }
    });
    return output;
  }

  Widget getContactSelector(List<Contact> contacts,Function(Contact) callback){
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: "Search by name / Id"),
            controller: searchc,
          ),

          SizedBox(height: 20,),

          SingleChildScrollView(
            child: Column(
              children: getContactCards(contacts,callback),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getContactCards(List<Contact> contacts,Function(Contact) callback){
    List<Widget> list = new List<Widget>();
    contacts.forEach((contact){
      list.add(
      GestureDetector(
        onTap: (){
          callback(contact);
          Navigator.of(context).pop();
        },
        child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(contact.contactName),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(contact.contactId.toString()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ))
      );
    });

    return list;
  }

}