class Device {
  final String id;
  final int battery;
  final bool charging;
  final DateTime date;
  final String location;
  final Map<String, dynamic> notificationSettings;
  final int status;
  final Map<String, dynamic> timeSlot;
  final String type;

  Device({
    required this.id,
    required this.battery,
    required this.charging,
    required this.date,
    required this.location,
    required this.notificationSettings,
    required this.status,
    required this.timeSlot,
    required this.type,
  });
}
