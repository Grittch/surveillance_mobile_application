import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/features/home/data/data_sources/detection_datasource.dart';
import 'package:iot_app_prot1/features/home/data/repository/detection_repository_impl.dart';
import 'package:iot_app_prot1/features/home/domain/entities/detection.dart';
import 'package:iot_app_prot1/features/home/domain/repository/detection_repository.dart';
import 'package:iot_app_prot1/features/home/domain/usecases/detection_usecases.dart';

final detectionRepositoryProvider = Provider<DetectionRepository>(
  (ref) => DetectionRepositoryImpl(ref.read(detectionRemoteDataSourceProvider)),
);

final detectionRemoteDataSourceProvider = Provider<DetectionRemoteDataSource>(
  (ref) => DetectionRemoteDataSourceImpl(),
);

final detectionUseCaseProvider = Provider<DetectionUseCase>(
  (ref) => DetectionUseCase(ref.read(detectionRepositoryProvider)),
);

final detectionListProvider = StreamProvider<List<DetectionEntity>>(
  (ref) {
    final dataSource = ref.watch(detectionRemoteDataSourceProvider);
    return dataSource.getDetectionsStream("UWNHFXzYiVCx7nz5AdGI");
  },
);
