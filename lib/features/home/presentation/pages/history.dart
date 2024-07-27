import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:iot_app_prot1/app_states/locale_states/locale_provider.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';
import 'package:iot_app_prot1/features/home/presentation/widgets/bar_graph.dart';
import 'package:iot_app_prot1/shared_widgets/detection_list.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class History extends ConsumerStatefulWidget {
  const History({super.key});

  @override
  ConsumerState<History> createState() => _HistoryState();
}

class _HistoryState extends ConsumerState<History> {
  List<Map<String, dynamic>> weeklyDetection = [
    {"date": 1696118400000, "value": 2.0},
    {"date": 1698796800000, "value": 5.0},
    {"date": 1701388800000, "value": 3.0},
    {"date": 1704067200000, "value": 1.0},
    {"date": 1706745600000, "value": 6.0},
    {"date": 1709251200000, "value": 3.0},
  ];

  @override
  Widget build(BuildContext context) {
    final size = ref.watch(screenSizeProvider);
    final Locale? appLocale = ref.watch(localeProvider);
    final textScaleFactor = size.width / 400;

    var firstMonth = DateFormat.MMMM(appLocale?.languageCode).format(DateTime(DateTime.now().year, 10));
    var lastMonth = DateFormat.MMMM(appLocale?.languageCode).format(DateTime(DateTime.now().year, 3));
    firstMonth = firstMonth[0].toUpperCase() + firstMonth.substring(1);
    lastMonth = lastMonth[0].toUpperCase() + lastMonth.substring(1);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "$firstMonth - $lastMonth",
                    style: TextStyle(fontSize: 18 * textScaleFactor),
                  ),
                  Container(
                    height: size.height * 0.25,
                    width: double.infinity,
                    child: CustomBarGraph(
                      weeklyDetection: weeklyDetection,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${AppLocalizations.of(context)!.label_detections}:", style: TextStyle(fontSize: 18 * textScaleFactor)),
                  IconButton(
                    icon: const Icon(
                      Icons.filter_alt_rounded,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const Expanded(
            child: DetectionList(),
          ),
        ],
      ),
    );
  }
}
