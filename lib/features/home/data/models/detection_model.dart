import 'package:iot_app_prot1/features/home/domain/entities/detection.dart';

class DetectionModel extends DetectionEntity {
  DetectionModel({
    required super.detectionId,
    required super.dateTime,
    required super.deviceId,
    required super.isFavorite,
    required super.name,
    required super.note,
    required super.tag,
  });

  factory DetectionModel.fromJson(Map<String, dynamic> json) {
    return DetectionModel(
      detectionId: json['detectionId'],
      dateTime: json['dateTime'],
      deviceId: json['deviceId'],
      isFavorite: json['isFavorite'],
      name: json['name'],
      note: json['note'],
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'detectionId': detectionId,
      'dateTime': dateTime,
      'deviceId': deviceId,
      'isFavorite': isFavorite,
      'name': name,
      'note': note,
      'tag': tag,
    };
  }
}
