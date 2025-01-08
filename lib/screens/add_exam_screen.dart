import 'package:flutter/material.dart';
import '../models/exam.dart';

class AddExamScreen extends StatefulWidget {
  @override
  _AddExamScreenState createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Exam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate == null
                      ? 'No date chosen'
                      : 'Date: ${_selectedDate.toString().split(' ')[0]}'),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: Text('Choose Date'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedTime == null
                      ? 'No time chosen'
                      : 'Time: ${_selectedTime!.format(context)}'),
                  ElevatedButton(
                    onPressed: _pickTime,
                    child: Text('Choose Time'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _selectedDate != null &&
                      _selectedTime != null) {
                    final dateTime = DateTime(
                      _selectedDate!.year,
                      _selectedDate!.month,
                      _selectedDate!.day,
                      _selectedTime!.hour,
                      _selectedTime!.minute,
                    );

                    final newExam = Exam(
                      subject: _subjectController.text,
                      dateTime: dateTime,
                      location: _locationController.text,
                    );

                    Navigator.pop(context, newExam);
                  }
                },
                child: Text('Add Exam'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}