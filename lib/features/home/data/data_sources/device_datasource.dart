import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/device_model.dart';

abstract class DeviceRemoteDataSource {
  Future<DeviceModel> getDeviceDetails(String userId, String deviceId);
  Future<QuerySnapshot<Map<String, dynamic>>> getDevicesForUser(String userId);
  Future<void> updateDeviceStatus(String userId, String deviceId, int newStatus);
}

class DeviceRemoteDataSourceImpl implements DeviceRemoteDataSource {
  final FirebaseFirestore firestore;

  DeviceRemoteDataSourceImpl({required this.firestore});

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getDevicesForUser(String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> userDevicesSnapshot = await firestore.collection('user').doc(userId).collection('devices').get();
      print(userDevicesSnapshot);

      return userDevicesSnapshot;
    } catch (e) {
      print('Errore durante il recupero dei dispositivi per l\'utente: $e');
      rethrow;
    }
  }

  @override
  Future<DeviceModel> getDeviceDetails(String userId, String deviceId) async {
    final deviceSnapshot = await firestore.collection('user').doc(userId).collection('devices').doc(deviceId).get();

    if (!deviceSnapshot.exists) {
      throw Exception('Device not found');
    }

    return DeviceModel.fromJson(deviceSnapshot.data()!);
  }

  @override
  Future<void> updateDeviceStatus(String userId, String deviceId, int newStatus) async {
    try {
      final deviceDoc = firestore.collection('user').doc(userId).collection('devices').doc(deviceId);

      await deviceDoc.update({'status': newStatus});
    } catch (e) {
      print('Errore durante l\'aggiornamento dello stato del dispositivo: $e');
      rethrow;
    }
  }
}
