import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyDatePicker extends StatefulWidget {
  @override
  _WeeklyDatePickerState createState() => _WeeklyDatePickerState();
}

class _WeeklyDatePickerState extends State<WeeklyDatePicker> {
  late List<DateTime> _weekDates;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _weekDates = _getWeekDates(_selectedDate);
  }

  List<DateTime> _getWeekDates(DateTime selectedDate) {
    List<DateTime> weekDates = [];
    DateTime firstDayOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    for (int i = 0; i < 7; i++) {
      weekDates.add(firstDayOfWeek.add(Duration(days: i)));
    }
    return weekDates;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _weekDates
            .map(
              (date) => GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: _weekDates.first,
                    lastDate: _weekDates.last,
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                      _weekDates = _getWeekDates(_selectedDate);
                    });
                  }
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: date.day == _selectedDate.day &&
                            date.month == _selectedDate.month &&
                            date.year == _selectedDate.year
                        ? Colors.blue.withOpacity(0.5)
                        : null,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.blue,
                      width: date.day == _selectedDate.day &&
                              date.month == _selectedDate.month &&
                              date.year == _selectedDate.year
                          ? 2.0
                          : 0.0,
                    ),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('MMM').format(date),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        DateFormat('dd').format(date),
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        DateFormat('EEE').format(date),
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class BookingPage extends StatefulWidget {
  BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late DateTime _selectedDate;
  int? _currentIndex;
  // bool _timeSelected = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now(); // Initialize with current date
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _weeklyDatePicker(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      'Select Consultation Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: _currentIndex == index ? Colors.blue : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _currentIndex == index ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
              childCount: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _weeklyDatePicker() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: WeeklyDatePicker(),
    );
  }
}
