import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';
import 'package:iot_app_prot1/features/home/domain/entities/detection.dart';
import 'package:iot_app_prot1/features/home/presentation/riverpod/detection_provider.dart';
import 'package:iot_app_prot1/shared_widgets/detection_dialog.dart';

class DetectionList extends ConsumerWidget {
  final bool showOnlyFavorites;
  final bool showTodayDetections;

  const DetectionList({
    super.key,
    this.showOnlyFavorites = false,
    this.showTodayDetections = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detections = ref.watch(detectionListProvider);
    final size = ref.watch(screenSizeProvider);

    return detections.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Text("Errore: $err"),
      data: (detections) {
        List<DetectionEntity> filteredDetections = detections;

        if (showOnlyFavorites) {
          filteredDetections = filteredDetections.where((detection) => detection.isFavorite).toList();
        }

        if (showTodayDetections) {
          DateTime now = DateTime.now();
          DateTime today = DateTime(now.year, now.month, now.day);

          filteredDetections = filteredDetections.where((detection) {
            DateTime detectionDate = DateTime(
              DateTime.fromMillisecondsSinceEpoch(detection.dateTime).year,
              DateTime.fromMillisecondsSinceEpoch(detection.dateTime).month,
              DateTime.fromMillisecondsSinceEpoch(detection.dateTime).day,
            );
            return detectionDate == today;
          }).toList();
        }

        filteredDetections.sort((a, b) => b.detectionId.compareTo(a.detectionId));

        filteredDetections.length;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: filteredDetections.length,
          itemBuilder: (BuildContext context, int index) {
            final detection = filteredDetections[index];
            return Card(
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              color: Theme.of(context).colorScheme.primary,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.005),
                  child: Text(
                    detection.name,
                  ),
                ),
                subtitle: Row(
                  children: [
                    AudioTag(tag: detection.tag),
                  ],
                ),
                trailing: const Icon(
                  Icons.play_arrow,
                  size: 20,
                ),
                onTap: () {
                  _showPopup(context, detection, size.height, size.width);
                },
              ),
            );
          },
        );
      },
    );
  }
}

class AudioTag extends StatelessWidget {
  final String tag;
  const AudioTag({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.tag_rounded,
              size: 14,
            ),
            Text(
              tag,
              style: TextStyle(
                fontSize: 14,
                fontFamily: GoogleFonts.inconsolata().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showPopup(BuildContext context, DetectionEntity detectionEntity, double height, double width) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DetectionDialog(
        detectionEntity: detectionEntity,
        heigth: height,
        width: width,
      );
    },
  );
}
