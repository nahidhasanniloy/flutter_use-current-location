import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/models/alarm.dart';
import 'package:task/utils/colors.dart';
import 'package:task/widgets/custom_button.dart';
import 'package:task/widgets/alarm_widget.dart';
import '../../AddAlarm/add_alarm_screen.dart';
import 'dart:math'; // Random ID তৈরির জন্য

class HomeScreen extends StatefulWidget {
  final String? selectedLocation;

  const HomeScreen({super.key, this.selectedLocation});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Alarm> alarms = [];

  @override
  void initState() {
    super.initState();
    _addDefaultAlarms();
  }

  void _addDefaultAlarms() {
    final now = DateTime.now();
    setState(() {
      alarms.add(Alarm(id: Random().nextInt(1000), scheduledTime: now.add(const Duration(minutes: 5))));
      alarms.add(Alarm(id: Random().nextInt(1000), scheduledTime: now.add(const Duration(minutes: 10))));
      alarms.add(Alarm(id: Random().nextInt(1000), scheduledTime: now.add(const Duration(minutes: 15))));
    });
  }

  void _addNewAlarm() async {
    final newAlarmTime = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddAlarmScreen()),
    );

    if (newAlarmTime != null) {
      setState(() {
        final newAlarm = Alarm(id: Random().nextInt(1000), scheduledTime: newAlarmTime);
        alarms.add(newAlarm);
        alarms.sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Selected Location",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.selectedLocation ?? "Location not available",
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'Add Alarm',
                      onPressed: _addNewAlarm,
                      color: AppColors.alarmButtonColor,
                      borderRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Alarms",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: alarms.length,
                  itemBuilder: (context, index) {
                    final alarm = alarms[index];
                    final time = DateFormat('hh:mm a').format(alarm.scheduledTime);
                    final date = DateFormat('E d MMM y').format(alarm.scheduledTime);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: AlarmTile(
                        time: time,
                        date: date,
                        alarmId: alarm.id,
                        scheduledTime: alarm.scheduledTime,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}