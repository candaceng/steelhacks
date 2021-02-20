import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Failed to launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.15), boxShadow: [BoxShadow(blurRadius: 10)]),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.png'),
                  radius: 55.0,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Center(child: Text('Personal', style: TextStyle(fontSize: 25))),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.15))]),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Age',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              )
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:  5.0),
                      Row(
                        children: <Widget> [
                          Expanded(
                            child: Text(
                              'Bob Joseph',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '18',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Gender',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                          ),
                          Expanded(
                            child: Text(
                                'School',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                )
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:  5.0),
                      Row(
                        children: <Widget> [
                          Expanded(
                            child: Text(
                              'Male',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'University of Toronto',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Center(child: Text('Mood History', style: TextStyle(fontSize: 25), textAlign: TextAlign.center)),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.15))]),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text('Last 30 days...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(height: 20),
                      LinearPercentIndicator(
                        leading: Text('😄  ', style: TextStyle(fontSize: 20)),
                        trailing: Text('   20%', style: TextStyle(fontSize: 15)),
                        alignment: MainAxisAlignment.center,
                        width: 220,
                        lineHeight: 20,
                        percent: 0.2,
                        progressColor: Colors.yellow,
                      ),
                      SizedBox(height: 20),
                      LinearPercentIndicator(
                        leading: Text('😐  ', style: TextStyle(fontSize: 20)),
                        trailing: Text('   50%', style: TextStyle(fontSize: 15)),
                        alignment: MainAxisAlignment.center,
                        width: 220,
                        lineHeight: 20,
                        percent: 0.5,
                        progressColor: Colors.orange,
                      ),
                      SizedBox(height: 20),
                      LinearPercentIndicator(
                        leading: Text('🙁  ', style: TextStyle(fontSize: 20)),
                        trailing: Text('   90%', style: TextStyle(fontSize: 15)),
                        alignment: MainAxisAlignment.center,
                        width: 220,
                        lineHeight: 20,
                        percent: 0.9,
                        progressColor: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Center(child: Text('Resources', style: TextStyle(fontSize: 25), textAlign: TextAlign.center)),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.15))]),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.lightBlue,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: 220,
                          child: InkWell(
                            onTap: () => _launchURL('https://toronto.cmha.ca/helpful-links/'),
                            child: Text('Canadian Mental Health Association', textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.lightBlue,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: 220,
                          child: InkWell(
                            onTap: () => _launchURL('https://www.mhfa.ca/en/general-resources'),
                            child: Text('Mental Health First Aid', textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.red,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: 220,
                          child: InkWell(
                            onTap: () => _launchURL('https://studentlife.utoronto.ca/task/get-24-hour-emergency-help-on-or-off-campus/'),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.phone),
                                SizedBox(width: 10),
                                Text('1-866-5312600'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]
        )
      ),
    );
  }
}

