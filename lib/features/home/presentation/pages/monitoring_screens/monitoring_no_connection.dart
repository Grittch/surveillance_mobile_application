import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonitoringNoConnection extends ConsumerWidget {
  const MonitoringNoConnection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = ref.watch(screenSizeProvider);
    final textScaleFactor = size.width / 400;

    double circleAvatarSize = size.width * 0.3;
    double iconSize = size.width * 0.45;
    return Center(
      child: Container(
        height: size.height * 0.45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: circleAvatarSize,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.signal_wifi_connected_no_internet_4_rounded,
                color: Colors.white,
                size: iconSize,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                AppLocalizations.of(context)!.description_no_connection,
                style: TextStyle(fontSize: 20 * textScaleFactor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
