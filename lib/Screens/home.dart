import 'package:flutter/material.dart';
import 'package:together_now_ipd/Models/widgets/app_bar.dart';
// import 'package:together_now_ipd/Models/widgets/search_bar.dart';
import 'package:together_now_ipd/Models/schedule_status.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomSearchBar(),
              SizedBox(
                height: 200,
              ),
              ScheduleStatus(
                  // hasAppointments: false, //
                  // onBookAppointment: () {
                  //   // Handle booking appointment
                  // },
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
