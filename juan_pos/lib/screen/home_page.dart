import 'package:flutter/material.dart';
import 'package:juan_pos/screen/contact_page.dart';
import 'package:juan_pos/screen/product_page.dart';
import 'package:juan_pos/screen/setting.dart';

class HomePage extends StatelessWidget {

  Card _makeDashboardItem(IconData icon, [ Function callback ]) {
    return Card(
      elevation: 0,
      margin: new EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(223, 230, 237, 1.0)),
        child: new InkWell(
          onTap: () {
            if (callback == null)
              return;

            callback();
          },
          child: Center(
            child: Icon(icon,
              size: 60.0,
              color: Color.fromRGBO(158, 173, 186, 1),
            ),
          ),
        ),
      )
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
          _makeDashboardItem(Icons.person, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));
          }),
          _makeDashboardItem(Icons.calendar_view_day, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));
          }),
          _makeDashboardItem(Icons.graphic_eq),
          _makeDashboardItem(Icons.format_list_numbered),
          _makeDashboardItem(Icons.lock),
          _makeDashboardItem(Icons.shopping_basket),
        ],
      ),
    );
  }

}
