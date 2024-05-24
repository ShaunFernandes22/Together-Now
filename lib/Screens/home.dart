import 'package:flutter/material.dart';
import 'package:together_now_ipd/Models/widgets/app_bar.dart';
// import 'package:together_now_ipd/Models/widgets/search_bar.dart';
import 'package:together_now_ipd/Models/schedule_status.dart';
import 'package:together_now_ipd/Screens/appointments/schedule_card.dart';
import 'package:together_now_ipd/Screens/booking.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                AppLocalizations.of(context)!.your_appointments,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              AppointmentCard(),
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
                  child: Text(
                    AppLocalizations.of(context)!.book_appointment,
                    style: const TextStyle( color: Colors.white,
                      fontSize: 20),
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
