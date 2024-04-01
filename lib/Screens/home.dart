import 'package:flutter/material.dart';
import 'package:together_now_ipd/Models/widgets/app_bar.dart';
// import 'package:together_now_ipd/Models/widgets/search_bar.dart';
import 'package:together_now_ipd/Models/schedule_status.dart';
import 'package:together_now_ipd/Screens/appointments/schedule_card.dart';
import 'package:together_now_ipd/Screens/booking.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomSearchBar(),
              // SizedBox(
              //   height: 200,
              // ),
              // ScheduleStatus(
              //     // hasAppointments: false, //
              //     // onBookAppointment: () {
              //     //   // Handle booking appointment
              //     // },
              //     ),
              Text(
                "Your Appointments",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              AppointmentCard(
                  doctorName: "Jon Snow",
                  category: "Cooking",
                  doctorProfile: 'assets/Person1.png',
                  day: "Wed",
                  date: "26 Mar",
                  time: "5:00 pm",
                  color: Color.fromARGB(255, 160, 208, 233)!,
                  onCancelPressed: () {},
                  onCompletePressed: () {}),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BookingPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    // padding: const EdgeInsets.all(8),
                    fixedSize: const Size(290, 55),
                    backgroundColor: const Color(0xFF4FC0D0),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Book an appointment',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
