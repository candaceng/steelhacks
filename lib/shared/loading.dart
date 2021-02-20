import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SpinKitDoubleBounce(
              color: Colors.lightBlue,
              size: 50.0,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Loading...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black45,
            ),
          ),
        ]
      ),
    );
  }
}

