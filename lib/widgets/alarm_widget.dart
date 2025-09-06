import 'package:flutter/material.dart';
import 'package:task/services/notification_service.dart';
import 'package:task/utils/colors.dart';
import 'package:task/utils/text_style.dart';

class AlarmTile extends StatefulWidget {
  final String time;
  final String date;
  final int alarmId;
  final DateTime scheduledTime;

  const AlarmTile({
    super.key,
    required this.time,
    required this.date,
    required this.alarmId,
    required this.scheduledTime,
  });

  @override
  State<AlarmTile> createState() => _AlarmTileState();
}

class _AlarmTileState extends State<AlarmTile> {
  final NotificationService _notificationService = NotificationService();
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    // অ্যাপ চালু হওয়ার সময় নোটিফিকেশনটি শিডিউল করা
    _notificationService.scheduleNotification(widget.alarmId, widget.scheduledTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.tileColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headingTwo(
            data: widget.time,
            textColor: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: headingThree(
              data: widget.date,
              textColor: AppColors.subTextColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          Switch(
            value: _isActive,
            onChanged: (value) {
              setState(() {
                _isActive = value;
              });

              if (_isActive) {
                // টগল অন হলে নোটিফিকেশন শিডিউল করবে
                _notificationService.scheduleNotification(
                  widget.alarmId,
                  widget.scheduledTime,
                );
              } else {
                // টগল অফ হলে নোটিফিকেশন বাতিল করবে
                _notificationService.cancelNotification(widget.alarmId);
              }
            },
            activeColor: AppColors.switchColor,
            inactiveTrackColor: AppColors.inActiveSwitchColor,
            inactiveThumbColor: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}