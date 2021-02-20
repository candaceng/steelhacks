import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steelhacks/shared/loading.dart';
import 'package:steelhacks/services/auth.dart';
import 'package:table_calendar/table_calendar.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2021, 1, 1): ['New Year\'s Day'],
  DateTime(2021, 1, 6): ['Epiphany'],
  DateTime(2021, 2, 14): ['Valentine\'s Day'],
  DateTime(2021, 4, 21): ['Easter Sunday'],
  DateTime(2021, 4, 22): ['Easter Monday'],
};

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  final AuthService _auth = AuthService();
  bool loading = false;
  bool _submitted = false;
  double _currentMood = 2;

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.15))]),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget> [
                      Center(child: Text('Hello 👋', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                      SizedBox(height: 10),
                      Center(child: Text("Here's your current schedule", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                      SizedBox(height: 10),
                      _buildTableCalendar(),
                      const SizedBox(height: 2.0),
                      _buildButtons(),
                      const SizedBox(height: 2.0),
                      ConstrainedBox(constraints: BoxConstraints(maxHeight: 200), child: _buildEventList()),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.15))]),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text('How do you feel today?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      SizedBox(height: 20),
                      Container(
                        width: 250,
                        child: Column(
                          children: <Widget> [
                            Slider(
                              value: _currentMood,
                              min: 1,
                              max: 3,
                              divisions: 2,
                              onChanged: (double value) {
                                setState(() {_currentMood = value;});
                              },
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget> [
                                      Text('🙁', style: TextStyle(fontSize: 25)),
                                      Text('😐', style: TextStyle(fontSize: 25)),
                                      Text('😄', style: TextStyle(fontSize: 25)),
                                    ]
                                )
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _submitted? false : true,
                        child: Column(
                          children: <Widget> [
                            SizedBox(height: 20),
                            FlatButton(
                              child: Text('Submit', style: TextStyle(fontSize: 20)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              color: Colors.lightBlue,
                              onPressed: () {
                                setState(() {
                                  _submitted = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: _submitted? 1.0 : 0.0, duration: Duration(milliseconds: 600),
                        child : Visibility(
                          visible: _submitted? true: false,
                          child: Column(
                            children: <Widget> [
                              SizedBox(height: 20),
                              Icon(Icons.check, color: Colors.green, size: 36),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.15))]),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget> [
                      Center(child: Text('Journal', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(hintText: 'Type here...', border: OutlineInputBorder()),
                        maxLines: null,
                      ),
                      SizedBox(height: 20),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Colors.lightBlue,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: 150,
                          child: InkWell(
                            onTap: () => {},
                            child: Text('02/15/2021', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Colors.lightBlue,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: 150,
                          child: InkWell(
                            onTap: () => {},
                            child: Text('02/14/2021', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Swim practice',
        'Calc exam',
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Swim practice'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.lightBlue,
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
        highlightToday: false,
        //weekendStyle: TextStyle(color: Colors.black),
        //holidayStyle: TextStyle(color: Colors.black),
      ),
      //daysOfWeekStyle: DaysOfWeekStyle(weekendStyle: TextStyle(color: Colors.black)),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        centerHeaderTitle: true,
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
            ? Colors.brown[300]
            : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildEventList() {
    return ListView(
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin:
        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    );
  }
}
