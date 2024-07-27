import 'package:iot_app_prot1/features/home/domain/entities/device.dart';

abstract class DeviceRepository {
  Future<List<String>> getDeviceIdsForUser(String userId);
  Future<Device> getDeviceDetails(String userId, String deviceId);
  Future<void> updateDeviceStatus(String deviceId, int newStatus);
}
