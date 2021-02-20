import 'package:steelhacks/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:steelhacks/services/auth.dart';
import 'package:steelhacks/shared/state.dart';
import 'package:provider/provider.dart';
import 'package:steelhacks/models/user.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/user.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(),
      child: Sensental(),
    ),
  );
}


class Sensental extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: Consumer<AppStateNotifier>(
        builder: (context, appState, child){
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.lightBlue,
              brightness: Brightness.light,
              textTheme: GoogleFonts.comfortaaTextTheme(Theme.of(context).textTheme),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.lightBlue,
              accentColor: Colors.lightBlue,
              brightness: Brightness.dark,
              textTheme: GoogleFonts.comfortaaTextTheme(Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white)),
            ),
            themeMode: appState.isDark? ThemeMode.dark : ThemeMode.light,
            home: Wrapper(),
          );
        }
      )
    );
  }
}



