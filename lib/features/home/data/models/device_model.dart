import '../../domain/entities/device.dart';

class DeviceModel extends Device {
  DeviceModel({
    required String id,
    required int battery,
    required bool charging,
    required DateTime date,
    required String location,
    required Map<String, dynamic> notificationSettings,
    required int status,
    required Map<String, dynamic> timeSlot,
    required String type,
  }) : super(
          id: id,
          battery: battery,
          charging: charging,
          date: date,
          location: location,
          notificationSettings: notificationSettings,
          status: status,
          timeSlot: timeSlot,
          type: type,
        );

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'],
      battery: json['battery'],
      charging: json['charging'],
      date: (json['date']).toDate(),
      location: json['location'],
      notificationSettings: json['notificationSettings'],
      status: json['status'],
      timeSlot: json['timeSlot'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'battery': battery,
      'charging': charging,
      'date': date,
      'location': location,
      'notificationSettings': notificationSettings,
      'status': status,
      'timeSlot': timeSlot,
      'type': type,
    };
  }
}
