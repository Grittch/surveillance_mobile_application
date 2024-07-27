import 'package:iot_app_prot1/features/home/domain/entities/detection.dart';
import 'package:iot_app_prot1/features/home/domain/repository/detection_repository.dart';

class DetectionUseCase {
  final DetectionRepository _repository;

  DetectionUseCase(this._repository);

  Stream<List<DetectionEntity>> getDetectionsStream(String userId) {
    return _repository.getDetectionsStream(userId);
  }

  Future<void> deleteDetection(String detectionId) async {
    return _repository.deleteDetection(detectionId);
  }

  Future<void> updateDetectionNote(String detectionId, String newNote) async {
    return _repository.updateDetectionNote(detectionId, newNote);
  }
}
