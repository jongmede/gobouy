import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  @override
  ContactPageState createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> _contactFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Form(
        key: _contactFormKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'NAME'),
                onChanged: (value) {

                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'ADDRESS'),
                onChanged: (value) {

                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'TIN'),
                onChanged: (value) {

                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'BUSINESS STYLE'),
                onChanged: (value) {

                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'SC ID / PWD ID'),
                onChanged: (value) {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}