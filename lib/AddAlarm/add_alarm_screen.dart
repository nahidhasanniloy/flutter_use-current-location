import 'package:flutter/material.dart';
import 'package:task/models/alarm.dart';
import 'package:task/utils/colors.dart';
import 'package:task/utils/text_style.dart';
import 'dart:math';
import 'package:intl/intl.dart';

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
      final newAlarm = Alarm(
        scheduledTime: _selectedDateTime!,
        id: Random().nextInt(100000),
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
        title: headingTwo(
          data: 'Set New Alarm',
          textColor: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.whiteColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _selectDateTime(context),

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.homeButtonColor,
                  foregroundColor: AppColors.whiteColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: headingThree(
                  data: 'Select Date and Time',
                  textColor: AppColors.whiteColor,
                ),
              ),
              const SizedBox(height: 20),
              if (_selectedDateTime != null)
                Text(
                  'Selected: ${DateFormat('hh:mm a, d MMM y').format(_selectedDateTime!)}',
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAlarm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.alarmButtonColor,
                  foregroundColor: AppColors.whiteColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: headingThree(
                  data: 'Save Alarm',
                  textColor: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
