import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatefulWidget {
  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  // Replace with your actual data
  final String work = 'Cash Deposit';

  final String date = 'Today';

  final String time = '1 pm';

  final String name = 'Martinez K';

  final String contactNo = '91723832';

  final String address = '36 --// Chattabazar,\nHyderabad,Mumbai,500002,India';

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(16.0), // Add padding around the card
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Work, Date, Time row with background color and rounded corners
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Work with background
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100], // Background color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text("Work: $work", style: TextStyle(fontSize: 13)),
                ),
                SizedBox(width: 5), // Add some spacing

                // Date with background
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100], // Background color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text("Date: $date", style: TextStyle(fontSize: 13)),
                ),
                SizedBox(width: 5), // Add some spacing

                // Time with background
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100], // Background color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text("Time: $time", style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
            SizedBox(height: 10), // Add some spacing

            // Title row (unchanged)
            Row(
              children: [
                Text('ELDER\'S DETAILS',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10,),
                Icon(Icons.person)
              ],
            ),
            SizedBox(height: 10), // Add some spacing

            // Rest of the content (profile picture, name, etc.)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile picture, name, contact number section (unchanged)
                CircleAvatar(
                  backgroundColor: Colors.grey[200], // Placeholder color
                  radius: 25.0,
                  child: Text('M'), // Initials or image
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: TextStyle(fontSize: 16)),
                      Text('Contact No: $contactNo', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),

                // Verified row with tick icon (unchanged)
              ],
            ),

            // Combined address and start button row
                SizedBox(height: 5,),
                // Verified text and icon (unchanged)
                Row(
                  children: [
                    Icon(Icons.verified, color: Colors.green),
                    SizedBox(width: 5),
                    Text('Verified'),
                  ],
                ),
                SizedBox(height: 5), // Add some space between verified and address

                // Expanded address section
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(address, style: TextStyle(fontSize: 14))),

                // Start button
                ElevatedButton(
                  onPressed: () {
                    // Handle Start button click
                  },
                  child: Text('START', style: TextStyle(color: Colors.white) ,),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Adjust color as needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

