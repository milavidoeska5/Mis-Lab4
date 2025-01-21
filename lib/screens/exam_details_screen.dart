import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:mis_lab4/screens/show_route_screen.dart';

class ExamDetailsScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailsScreen({Key? key, required this.exam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subject: ${exam.subject}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Location: ${exam.location}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Date: ${exam.dateTime.toString().split(' ')[0]}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Time: ${exam.dateTime.toString().split(' ')[1]}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowRouteScreen(
                      destinationLat: exam.latitude!,
                      destinationLng: exam.longitude!,
                    ),
                  ),
                );
              },
              child: Text('Show Shortest Route'),
            ),
          ],
        ),
      ),
    );
  }
}
