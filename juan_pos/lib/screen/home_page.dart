import 'package:flutter/material.dart';
import 'package:juan_pos/screen/contact_page.dart';
import 'package:juan_pos/screen/product_page.dart';
import 'package:juan_pos/screen/sales_invoice_list_page.dart';
import 'package:juan_pos/screen/sales_invoice_page.dart';
import 'package:juan_pos/screen/setting.dart';

class HomePage extends StatelessWidget {

  Card _makeDashboardItem(IconData icon, String label, [ Function callback ]) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(223, 230, 237, 1.0)),
            child: InkWell(
              onTap: () {
                if (callback == null)
                  return;

                callback();
              },
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Icon(icon,
                    size: 50.0,
                    color: Color.fromRGBO(158, 173, 186, 1),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) {
              var list = List<PopupMenuEntry<Object>>();
              list.add(PopupMenuItem(
                child: Text('Settings'),
                value: 'settings',
              ));
              return list;
            },
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
              }
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(20),
        children: <Widget>[
          _makeDashboardItem(Icons.person, 'CONTACTS', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));
          }),
          _makeDashboardItem(Icons.calendar_view_day, 'PRODUCTS', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));
          }),
          _makeDashboardItem(Icons.graphic_eq, 'REPORTS'),
          _makeDashboardItem(Icons.format_list_numbered, 'INVOICES', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SalesInvoiceListPage()));
          }),
          _makeDashboardItem(Icons.lock, 'USERS'),
          _makeDashboardItem(Icons.shopping_basket, 'SALES', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SalesInvoicePage()));
          }),
        ],
      ),
    );
  }

}
