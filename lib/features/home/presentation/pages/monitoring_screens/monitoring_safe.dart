import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';
import 'package:iot_app_prot1/shared_widgets/monitoring_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonitoringSafe extends ConsumerStatefulWidget {
  const MonitoringSafe({super.key});

  @override
  ConsumerState<MonitoringSafe> createState() => _MonitoringSafeState();
}

class _MonitoringSafeState extends ConsumerState<MonitoringSafe> {
  List<int> soundDetected = [2, 0];

  @override
  Widget build(BuildContext context) {
    final size = ref.watch(screenSizeProvider);
    final textScaleFactor = size.width / 400;

    double circleAvatarSize = size.width * 0.3;
    double iconSize = size.width * 0.55;

    return Center(
      child: Container(
        height: size.height * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: circleAvatarSize,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.shield_rounded,
                color: Colors.white,
                size: iconSize,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                AppLocalizations.of(context)!.description_no_detections,
                style: TextStyle(fontSize: 20 * textScaleFactor),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MonitoringCard(
                  type: AppLocalizations.of(context)!.label_detections,
                  number: soundDetected[0],
                  width: size.width,
                  height: size.height,
                ),
                MonitoringCard(
                  type: AppLocalizations.of(context)!.label_suspicious,
                  number: soundDetected[1],
                  width: size.width,
                  height: size.height,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
