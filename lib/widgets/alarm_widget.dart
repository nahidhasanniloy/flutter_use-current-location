import 'package:flutter/material.dart';
import 'package:task/utils/colors.dart';

class AlarmTile extends StatelessWidget {
  final String time;
  final String date;
  final int alarmId;
  final DateTime scheduledTime;
  final VoidCallback onDelete;
  final bool isActive;
  final ValueChanged<bool> onToggle;

  const AlarmTile({
    super.key,
    required this.time,
    required this.date,
    required this.alarmId,
    required this.scheduledTime,
    required this.onDelete,
    required this.isActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
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
                  ],
                ),
                const SizedBox(width: 38),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Transform.scale(
              scale: 1.1,
              child: Switch(
                value: isActive,
                onChanged: onToggle,
                activeColor: Color(0xff7b4cdf),
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
