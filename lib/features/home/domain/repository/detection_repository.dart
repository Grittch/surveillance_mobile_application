import 'package:iot_app_prot1/features/home/domain/entities/detection.dart';

abstract class DetectionRepository {
  Stream<List<DetectionEntity>> getDetectionsStream(String userId);
  Future<void> deleteDetection(String detectionId);
  Future<void> updateDetectionNote(String detectionId, String newNote);
}
