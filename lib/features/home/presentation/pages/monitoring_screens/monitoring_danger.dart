import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';
import 'package:iot_app_prot1/shared_widgets/detection_list.dart';
import 'package:iot_app_prot1/shared_widgets/monitoring_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonitoringDanger extends ConsumerStatefulWidget {
  final int detectionsNumber;
  const MonitoringDanger({super.key, required this.detectionsNumber});

  @override
  ConsumerState<MonitoringDanger> createState() => _MonitoringDangerState();
}

class _MonitoringDangerState extends ConsumerState<MonitoringDanger> {
  @override
  Widget build(BuildContext context) {
    final size = ref.watch(screenSizeProvider);
    final textScaleFactor = size.width / 400;

    double circleAvatarSize = size.width * 0.3;
    double iconSize = size.width * 0.55;

    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: circleAvatarSize,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.dangerous_outlined,
                color: Colors.white,
                size: iconSize,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                AppLocalizations.of(context)!.description_yes_detections,
                style: TextStyle(fontSize: 20 * textScaleFactor),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MonitoringCard(
                  type: AppLocalizations.of(context)!.label_detections,
                  number: widget.detectionsNumber,
                  width: size.width,
                  height: size.height,
                ),
                MonitoringCard(
                  type: AppLocalizations.of(context)!.label_suspicious,
                  number: widget.detectionsNumber,
                  width: size.width,
                  height: size.height,
                ),
              ],
            ),
            Text(
              "${AppLocalizations.of(context)!.label_detections}:",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18 * textScaleFactor,
              ),
            ),
            const Expanded(
              child: DetectionList(
                showTodayDetections: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
