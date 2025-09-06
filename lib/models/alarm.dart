
class Alarm {
  final int id;
  final DateTime scheduledTime;
  bool isActive; // New property to track the on/off state

  Alarm({required this.id, required this.scheduledTime, this.isActive = true});
}