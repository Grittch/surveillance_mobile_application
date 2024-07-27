import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot_app_prot1/features/home/data/data_sources/device_datasource.dart';
import 'package:iot_app_prot1/features/home/domain/repository/device_repository.dart';
import '../../domain/entities/device.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final DeviceRemoteDataSource remoteDataSource;

  DeviceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<String>> getDeviceIdsForUser(String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> userDevicesSnapshot = await remoteDataSource.getDevicesForUser(userId);
      print(userDevicesSnapshot.docs.map((doc) => doc.id).toList());
      return userDevicesSnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print('Errore durante il recupero degli ID dei dispositivi: $e');
      rethrow;
    }
  }

  @override
  Future<Device> getDeviceDetails(String userId, String deviceId) async {
    return await remoteDataSource.getDeviceDetails(userId, deviceId);
  }

  Future<void> updateDeviceStatus(String deviceId, int newStatus) async {
    try {
      final deviceDoc = FirebaseFirestore.instance.collection('devices').doc(deviceId);
      await deviceDoc.update({'status': newStatus});
    } catch (e) {
      print('Errore durante l\'aggiornamento dello stato del dispositivo: $e');
      rethrow;
    }
  }
}
