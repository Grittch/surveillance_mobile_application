import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/features/home/data/data_sources/device_datasource.dart';
import 'package:iot_app_prot1/features/home/data/repository/device_repository_impl.dart';
import 'package:iot_app_prot1/features/home/domain/usecases/get_device_details.dart';
import '../../domain/entities/device.dart';

import 'package:iot_app_prot1/features/home/domain/repository/device_repository.dart';

final deviceRepositoryProvider = Provider<DeviceRepository>((ref) {
  return DeviceRepositoryImpl(
    remoteDataSource: DeviceRemoteDataSourceImpl(
      firestore: FirebaseFirestore.instance,
    ),
  );
});

final getDeviceDetailsUseCaseProvider = Provider<GetDeviceDetails>((ref) {
  final deviceRepository = ref.read(deviceRepositoryProvider);
  return GetDeviceDetails(deviceRepository);
});

final deviceDetailsProvider = FutureProvider.autoDispose.family<List<Device>, String>((ref, userId) async {
  final deviceRepository = ref.read(deviceRepositoryProvider);

  final deviceIds = await deviceRepository.getDeviceIdsForUser(userId);

  final List<Device> devices = await Future.wait(deviceIds.map((deviceId) async {
    return await deviceRepository.getDeviceDetails(userId, deviceId);
  }));

  return devices;
});
