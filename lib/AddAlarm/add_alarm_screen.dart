import 'package:flutter/material.dart';
import 'package:task/models/alarm.dart';
import 'package:task/utils/colors.dart';
import 'dart:math'; // Random() ব্যবহার করার জন্য এটি যোগ করতে হবে

class AddAlarmScreen extends StatefulWidget {
  const AddAlarmScreen({super.key});

  @override
  State<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  DateTime? _selectedDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _saveAlarm() {
    if (_selectedDateTime != null) {
      // একটি অনন্য (unique) আইডি তৈরি করা হচ্ছে
      final newAlarm = Alarm(
        scheduledTime: _selectedDateTime!,
        id: Random().nextInt(100000), // একটি বড় সংখ্যা ব্যবহার করা হয়েছে
      );
      Navigator.pop(context, newAlarm);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date and time')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Set New Alarm'),
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.whiteColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _selectDateTime(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.homeButtonColor,
                foregroundColor: AppColors.whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text('Select Date and Time'),
            ),
            const SizedBox(height: 20),
            if (_selectedDateTime != null)
              Text(
                'Selected: ${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year} at ${_selectedDateTime!.hour}:${_selectedDateTime!.minute}',
                style: TextStyle(fontSize: 18, color: AppColors.whiteColor),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAlarm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.homeButtonColor,
                foregroundColor: AppColors.whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text('Save Alarm'),
            ),
          ],
        ),
      ),
    );
  }
}