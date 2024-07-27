import 'package:iot_app_prot1/features/home/data/data_sources/detection_datasource.dart';
import 'package:iot_app_prot1/features/home/domain/entities/detection.dart';
import 'package:iot_app_prot1/features/home/domain/repository/detection_repository.dart';

class DetectionRepositoryImpl implements DetectionRepository {
  final DetectionRemoteDataSource remoteDataSource;

  DetectionRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<DetectionEntity>> getDetectionsStream(String userId) {
    return remoteDataSource.getDetectionsStream(userId);
  }

  @override
  Future<void> deleteDetection(String detectionId) async {
    await remoteDataSource.deleteDetection(detectionId);
  }

  @override
  Future<void> updateDetectionNote(String detectionId, String newNote) async {
    await remoteDataSource.updateDetectionNote(detectionId, newNote);
  }
}
