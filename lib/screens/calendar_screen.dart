import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/exam.dart';
import 'add_exam_screen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<Exam>> _examsByDate = {};

  void _addExam(Exam exam) {
    setState(() {
      final date = DateTime(exam.dateTime.year, exam.dateTime.month, exam.dateTime.day);
      if (_examsByDate[date] == null) {
        _examsByDate[date] = [];
      }
      _examsByDate[date]!.add(exam);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Calendar'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newExam = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddExamScreen(),
                ),
              );
              if (newExam != null && newExam is Exam) {
                _addExam(newExam);
                setState(() {
                  _selectedDay = _focusedDay; // Refresh the calendar with the updated day.
                });
              }
            },
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update focusedDay when changing the selected day
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            const SizedBox(height: 16),
            if (_selectedDay != null)
              Expanded(
                child: ListView(
                  children: _examsByDate[DateTime(
                      _selectedDay!.year,
                      _selectedDay!.month,
                      _selectedDay!.day)] != null
                      ? _examsByDate[DateTime(
                      _selectedDay!.year,
                      _selectedDay!.month,
                      _selectedDay!.day)]!
                      .map((exam) => ListTile(
                    title: Text(exam.subject),
                    subtitle: Text('${exam.dateTime} at ${exam.location}'),
                  ))
                      .toList()
                      : [
                    Text(
                      'No exams for the selected day.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )

          ],
        ),
      ),
    );
  }
}