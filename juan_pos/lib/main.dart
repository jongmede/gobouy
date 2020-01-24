import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:juan_pos/screen/root_page.dart';
import 'package:juan_pos/service/authentication.dart';
import 'package:juan_pos/util/dynamic_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider<DynamicTheme>(
    create: (context) => DynamicTheme(),
    child: MyApp()
  ),
);

class MyApp extends StatefulWidget {

  static final storage = new FlutterSecureStorage();

  const MyApp();

  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _fetchTheme();
  }

  Future<void> _fetchTheme() async {
    if ((await MyApp.storage.read(key: 'dark')) == 'true') {
      final themeProvider = Provider.of<DynamicTheme>(context, listen: false);
      themeProvider.changeDarkMode(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);
    final ThemeData dark = ThemeData(
      primaryColor: Colors.teal,
      accentColor: Colors.teal,
      accentColorBrightness: Brightness.dark,
      brightness: Brightness.dark
    );
    final ThemeData light = ThemeData(
      primaryColor: Colors.teal,
      accentColor: Colors.teal,
      accentColorBrightness: Brightness.light,
      brightness: Brightness.light
    );

    return MaterialApp(
      theme: themeProvider.getDarkMode() ? dark: light,
      home: RootPage(auth: Auth())
    );
  }
}
