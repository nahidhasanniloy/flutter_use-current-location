// lib/widgets/alarm_widget.dart

import 'package:flutter/material.dart';
import 'package:task/services/notification_service.dart';
import 'package:task/utils/colors.dart';

class AlarmTile extends StatelessWidget {
  final String time;
  final String date;
  final int alarmId;
  final DateTime scheduledTime;
  final VoidCallback onDelete;

  const AlarmTile({
    super.key,
    required this.time,
    required this.date,
    required this.alarmId,
    required this.scheduledTime,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final NotificationService notificationService = NotificationService();

    return Dismissible(
      key: Key(alarmId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        notificationService.cancelNotification(alarmId);
        onDelete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Alarm with ID $alarmId dismissed')),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.tileColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.alarm, color: AppColors.whiteColor, size: 24),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14,
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