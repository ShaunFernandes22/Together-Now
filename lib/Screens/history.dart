import 'package:flutter/material.dart';
import 'package:together_now_ipd/Screens/appointments/schedule_card.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 22,),
          Text("Your Previous Appointments", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
          AppointmentCard(),
          AppointmentCard(),
          AppointmentCard(),
          AppointmentCard(),
        ],
      ),
    );
  }
}
