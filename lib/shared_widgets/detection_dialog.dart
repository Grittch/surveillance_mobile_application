import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/core/constants/constants.dart';
import 'package:iot_app_prot1/features/home/domain/entities/detection.dart';
import 'package:iot_app_prot1/shared_widgets/custom_snackbar.dart';
import 'package:iot_app_prot1/shared_widgets/custom_textfield.dart';
import 'package:iot_app_prot1/shared_widgets/info_row.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetectionDialog extends ConsumerStatefulWidget {
  final DetectionEntity detectionEntity;
  final double width;
  final double heigth;

  const DetectionDialog({
    super.key,
    required this.detectionEntity,
    required this.width,
    required this.heigth,
  });

  @override
  ConsumerState<DetectionDialog> createState() => _DetectionDialogState();
}

class _DetectionDialogState extends ConsumerState<DetectionDialog> {
  TextEditingController noteController = TextEditingController();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    noteController.text = widget.detectionEntity.note;
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = widget.width / 400;

    return Dialog(
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.width * 0.03, vertical: widget.heigth * 0.01),
        child: Container(
          width: widget.width * 0.75,
          height: widget.heigth * 0.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      widget.detectionEntity.isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                      size: 24 * textScaleFactor,
                      color: Colors.red.shade800,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    widget.detectionEntity.name,
                    style: TextStyle(fontSize: 24 * textScaleFactor),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.download,
                      size: 24 * textScaleFactor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Container(
                height: widget.heigth * 0.08,
                child: const Placeholder(),
              ),
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: widget.heigth * 0.015),
                child: Column(
                  children: [
                    InfoRow(
                        label: AppLocalizations.of(context)!.label_day,
                        value: formatDateTime(DateTime.fromMillisecondsSinceEpoch(widget.detectionEntity.dateTime))),
                    InfoRow(
                        label: AppLocalizations.of(context)!.label_hour,
                        value: formatTime(DateTime.fromMillisecondsSinceEpoch(widget.detectionEntity.dateTime))),
                    InfoRow(label: "Tag", value: widget.detectionEntity.tag[0].toUpperCase() + widget.detectionEntity.tag.substring(1)),
                    InfoRow(
                        label: AppLocalizations.of(context)!.label_device,
                        value:
                            "${widget.detectionEntity.deviceId.substring(0, 6)}...${widget.detectionEntity.deviceId.substring(widget.detectionEntity.deviceId.length - 6)}")
                  ],
                ),
              ),
              CustomTextField(
                controller: noteController,
                hintText: AppLocalizations.of(context)!.label_notes,
                maxLines: 4,
                maxLength: 128,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0.0),
                  backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  CustomSnackbar.show(
                    context,
                    AppLocalizations.of(context)!.snackbar_popup,
                    AppLocalizations.of(context)!.snackbar_popup_description,
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.button_send,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
