// data/datasources/detection_remote_data_source.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:iot_app_prot1/features/home/data/models/detection_model.dart';
import 'package:iot_app_prot1/features/home/domain/entities/detection.dart';

abstract class DetectionRemoteDataSource {
  Stream<List<DetectionEntity>> getDetectionsStream(String userId);
  Future<void> deleteDetection(String detectionId);
  Future<void> updateDetectionNote(String detectionId, String newNote);
}

class DetectionRemoteDataSourceImpl implements DetectionRemoteDataSource {
  final FirebaseDatabase database = FirebaseDatabase(
    databaseURL: 'https://audioguard-e1972-default-rtdb.europe-west1.firebasedatabase.app/',
  );

  @override
  Stream<List<DetectionEntity>> getDetectionsStream(String userId) {
    final ref = database.ref('users/$userId/detections');

    return ref.onValue.map((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      final detections = data.entries.map((e) {
        final value = Map<String, dynamic>.from(e.value as Map);
        return DetectionModel(
          detectionId: e.key,
          dateTime: value['dateTime'],
          deviceId: value['deviceId'],
          isFavorite: value['isFavorite'],
          name: value['name'],
          note: value['note'],
          tag: value['tag'],
        );
      }).toList();
      return detections;
    });
  }

  @override
  Future<void> deleteDetection(String detectionId) async {
    final ref = database.ref('users/UWNHFXzYiVCx7nz5AdGI/detections/$detectionId'); // UID HARDCODED
    await ref.remove();
  }

  @override
  Future<void> updateDetectionNote(String detectionId, String newNote) async {
    final ref = database.ref('users/UWNHFXzYiVCx7nz5AdGI/detections/$detectionId'); // UID HARDCODED
    await ref.update({'note': newNote});
  }
}
