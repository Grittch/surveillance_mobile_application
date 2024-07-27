import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iot_app_prot1/features/home/presentation/pages/monitoring_screens/monitoring_danger.dart';
import 'package:iot_app_prot1/features/home/presentation/pages/monitoring_screens/monitoring_no_connection.dart';
import 'package:iot_app_prot1/features/home/presentation/pages/monitoring_screens/monitoring_safe.dart';

class Monitoring extends StatelessWidget {
  final bool isLastDetectionToday;
  final int detectionsNumber;

  const Monitoring({
    super.key,
    required this.isLastDetectionToday,
    required this.detectionsNumber,
  });

  Future<Widget> getMonitoringScreen(bool isLastDetectionToday) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return isLastDetectionToday
            ? MonitoringDanger(
                detectionsNumber: detectionsNumber,
              )
            : MonitoringSafe();
      }
    } catch (_) {
      // DA IMPLEMENTARE
    }
    return const MonitoringNoConnection();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getMonitoringScreen(isLastDetectionToday),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Errore: ${snapshot.error}');
        } else {
          return snapshot.data ?? const Text('Errore sconosciuto.');
        }
      },
    );
  }
}
