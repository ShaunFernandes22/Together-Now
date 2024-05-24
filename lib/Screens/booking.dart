import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late DateTime _selectedDate;
  int? _currentIndex;
  bool _isButtonEnabled = false;
  final TextEditingController _workDetailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now(); // Initialize with current date
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _selectedDate != null && _currentIndex != null  &&
          _workDetailsController.text.isNotEmpty;;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.select_consult_date,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                  ),
                  child: DatePicker(
                    DateTime.now(),
                    height: 100,
                    width: 80,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.blue.shade800,
                    selectedTextColor: Colors.white,
                    dateTextStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    monthTextStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    dayTextStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    onDateChange: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                      _updateButtonState();
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.select_consult_time,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _timeSlots(),
          
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                  child: Center(
                    child: Text(
                      "Enter work details",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 10, left: 15, right: 15),
                    child: TextFormField(
                      controller: _workDetailsController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Enter the task that you need assistance with",
                      ),
                      onChanged: (value) {
                        _updateButtonState();
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled ? _fixAppointment : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isButtonEnabled
                            ? Colors.blue.shade800
                            : Colors.grey, // Background color
                        fixedSize: Size(250, 50)
                      ),
                      
                      child: Text("Fix Appointment",
                                style: TextStyle(fontSize: 18,
                                color: _isButtonEnabled? Colors.white : Colors.black),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeSlots() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                _currentIndex = index;
              });
              _updateButtonState();
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _currentIndex == index ? Colors.white : Colors.black,
                ),
                borderRadius: BorderRadius.circular(15),
                color: _currentIndex == index ? Colors.blue.shade800 : null,
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
        childCount: 10,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.5,
      ),
    );
  }

  void _fixAppointment() {
    // Handle appointment fixing logic here
    String date = DateFormat('dd-MM-yyyy').format(_selectedDate);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Appointment fixed for $date at ${_currentIndex! + 9}:00'),
      ),
    );
  }
}
