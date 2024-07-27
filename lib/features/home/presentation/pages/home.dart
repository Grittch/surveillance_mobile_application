import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/features/home/presentation/pages/history.dart';
import 'package:iot_app_prot1/features/home/presentation/pages/devices.dart';
import 'package:iot_app_prot1/features/home/presentation/pages/monitoring.dart';
import 'package:iot_app_prot1/features/home/presentation/pages/remote_access.dart';
import 'package:iot_app_prot1/features/home/presentation/riverpod/detection_provider.dart';

class Home extends ConsumerWidget {
  final int index;

  const Home({super.key, required this.index});

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detections = ref.watch(detectionListProvider);

    return detections.when(
      data: (detections) {
        final hasDetectionsToday = detections.any((detection) => isSameDay(DateTime.fromMillisecondsSinceEpoch(detection.dateTime), DateTime.now()));
        return getSpecificContainer(index, hasDetectionsToday, detections.length);
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, stack) => Text('Error: $e'),
    );
  }
}

Widget getSpecificContainer(int index, bool hasDetectionsToday, int detectionsNumber) {
  switch (index) {
    case 0:
      return Monitoring(
        isLastDetectionToday: hasDetectionsToday,
        detectionsNumber: detectionsNumber,
      );
    case 1:
      return const RemoteAccess();
    case 2:
      return const History();
    case 3:
      return const Devices();
    default:
      return Container();
  }
}
