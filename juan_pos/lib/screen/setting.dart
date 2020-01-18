import 'package:flutter/material.dart';
import 'package:juan_pos/main.dart';
import 'package:juan_pos/util/dynamic_theme.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {

  @override
  void initState() {
    super.initState();
    _fetchTheme();
  }

  Future<void> _fetchTheme() async {
    if ((await MyApp.storage.read(key: 'dark')) == 'true') {
      final themeProvider = Provider.of<DynamicTheme>(context);
      themeProvider.changeDarkMode(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Theme',
            tiles: [
              SettingsTile.switchTile(
                title: 'Dark Mode',
                leading: Icon(
                  Icons.brightness_medium,
                  color: Theme.of(context).primaryColor
                ),
                switchValue: themeProvider.getDarkMode(),
                onToggle: (bool value) {
                  themeProvider.changeDarkMode(value);

                  if (value)
                    MyApp.storage.write(key: 'dark', value: value.toString());
                  else
                    MyApp.storage.delete(key: 'dark');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

}
