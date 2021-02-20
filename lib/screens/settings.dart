import 'package:flutter/material.dart';
import 'package:steelhacks/shared/state.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:steelhacks/services/auth.dart';

class Settings extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: SettingsList(
          sections: [
            SettingsSection(
              title: 'Account',
              tiles: [
                SettingsTile(
                  title: 'Email',
                  //subtitle: 'English',
                  leading: Icon(Icons.email),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Sign Out',
                  leading: Icon(Icons.logout),
                  onPressed: (BuildContext context) async {
                    await _auth.signOut();
                    Navigator.pop(context);
                  },
                ),
                SettingsTile(
                  title: 'Delete Account',
                  titleTextStyle: TextStyle(color: Colors.red),
                  leading: Icon(Icons.delete, color: Colors.red),
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
            SettingsSection(
              title: 'Preferences',
              tiles: [
                SettingsTile.switchTile(
                  title: 'Dark Mode',
                  leading: Icon(Icons.wb_sunny),
                  switchValue: Provider.of<AppStateNotifier>(context).isDark,
                  onToggle: (bool value) {
                    Provider.of<AppStateNotifier>(context).updateTheme(value);
                  },
                ),
              ],
            ),
            SettingsSection(
              title: 'About',
              tiles: [
                SettingsTile(
                  title: 'Privacy Policy',
                  leading: Icon(Icons.privacy_tip),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'License Agreement',
                  leading: Icon(Icons.file_copy),
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
            SettingsSection(
              title: 'Support',
              tiles: [
                SettingsTile(
                  title: 'FAQ',
                  leading: Icon(Icons.question_answer),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Report a Bug',
                  leading: Icon(Icons.bug_report),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Give Feedback',
                  leading: Icon(Icons.feedback),
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

    
