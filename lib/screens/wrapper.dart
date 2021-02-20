import 'package:steelhacks/screens/home/home.dart';
import 'package:steelhacks/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:steelhacks/screens/profile/profile.dart';
import 'package:steelhacks/screens/settings.dart';
import 'package:steelhacks/shared/state.dart';
import 'package:provider/provider.dart';
import 'package:steelhacks/models/user.dart';
import 'package:steelhacks/services/auth.dart';
import 'chatbot/chatbot.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with TickerProviderStateMixin{
  final AuthService _auth = AuthService();
  final List<Widget> _route = [
    Home(),
    Chatbot(),
    Profile()
  ];
  final List<String> _title = [
    "Home",
    "Chat",
    "Profile"
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // return either authenticate or home
    /*if (user == null) {
      return Authenticate();
    } else {*/
      return Scaffold(
        appBar: AppBar(
          title: Text(
            _title[_selectedIndex],
            style: TextStyle(color: Provider.of<AppStateNotifier>(context).isDark? Colors.white : Colors.grey[900]),
          ),
          centerTitle: true,
          leadingWidth: 200,
          backgroundColor: Colors.lightBlue[500],
          elevation: 1.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              color: Provider.of<AppStateNotifier>(context).isDark? Colors.white : Colors.black,
              tooltip: "Settings",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
            SizedBox(width: 10),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.lightBlue,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
              print(_selectedIndex);
            });
          },
          type: BottomNavigationBarType.fixed,
        ),
        body: _route[_selectedIndex],
      );
    //}
  }

}
