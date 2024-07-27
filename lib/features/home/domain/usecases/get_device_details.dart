import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/features/home/domain/entities/device.dart';
import 'package:iot_app_prot1/features/home/domain/repository/device_repository.dart';
import 'package:iot_app_prot1/features/home/presentation/riverpod/device_provider.dart';

final getDeviceDetailsUseCaseProvider = Provider<GetDeviceDetails>((ref) {
  final repository = ref.read(deviceRepositoryProvider);
  return GetDeviceDetails(repository);
});

class GetDeviceDetails {
  final DeviceRepository _repository;

  GetDeviceDetails(this._repository);

  Future<Device> call(String deviceId) async {
    return await _repository.getDeviceDetails("UWNHFXzYiVCx7nz5AdGI", deviceId);
  }
}
