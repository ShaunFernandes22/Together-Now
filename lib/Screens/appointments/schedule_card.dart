import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String category;
  final String doctorProfile;
  final String day;
  final String date;
  final String time;
  final Color color;
  final VoidCallback onCancelPressed;
  final VoidCallback onCompletePressed;

  AppointmentCard({
    required this.doctorName,
    required this.category,
    required this.doctorProfile,
    required this.day,
    required this.date,
    required this.time,
    required this.color,
    required this.onCancelPressed,
    required this.onCompletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 4, // Add elevation for shadow effect
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(doctorProfile),
                    radius: 40, // Adjust avatar size
                  ),
                  SizedBox(width: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr $doctorName',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        category,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  '$day, $date',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Center(
                child: Text(
                  time,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: onCancelPressed,
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: onCompletePressed,
                    child: Text('Completed',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
