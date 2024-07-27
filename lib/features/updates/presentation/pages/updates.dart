import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Updates extends StatefulWidget {
  const Updates({super.key});

  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  final List<List<dynamic>> updates = [
    ["AGPro", "V.9.44.70.JS", 28.5, 3],
    ["AGLite", "V.2.100.45.BX", 5, 1],
    ["AgLite", "V.1.25.78.PF", 17, 2],
    ["AGPortable", "V.1.152.98.WA", 123.8, 3],
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: updates.length,
      itemBuilder: (context, index) {
        return UpdateTile(
          updateData: updates[index],
          onDownloadComplete: () {
            setState(() {
              updates.removeAt(index);
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          height: 1,
          thickness: 1,
        );
      },
    );
  }
}

class UpdateTile extends StatefulWidget {
  final List<dynamic> updateData;
  final VoidCallback? onDownloadComplete;

  const UpdateTile({
    super.key,
    required this.updateData,
    this.onDownloadComplete,
  });

  @override
  _UpdateTileState createState() => _UpdateTileState();
}

class _UpdateTileState extends State<UpdateTile> {
  int downloadProgress = 0;
  bool isDownloadStarted = false;
  bool isDownloadFinished = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.updateData[0]),
      subtitle: Text(
        widget.updateData[1],
        style: TextStyle(color: Colors.grey.shade700),
      ),
      leading: Icon(
        updateIcon(widget.updateData[3]),
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: isDownloadStarted,
            replacement: IconButton(
              icon: const Icon(Icons.download),
              color: isDownloadFinished ? Colors.green.shade600 : Colors.grey,
              onPressed: downloadCourse,
            ),
            child: CircularPercentIndicator(
              radius: 20.0,
              lineWidth: 3.0,
              percent: (downloadProgress / 100),
              center: Text(
                "$downloadProgress%",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              progressColor: Theme.of(context).colorScheme.primary,
              onAnimationEnd: () {
                if (downloadProgress == 100 && widget.onDownloadComplete != null) {
                  widget.onDownloadComplete!();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void downloadCourse() async {
    setState(() {
      isDownloadStarted = true;
      isDownloadFinished = false;
      downloadProgress = 0;
    });

    while (downloadProgress < 100) {
      downloadProgress += Random().nextInt(10) + 1;
      downloadProgress = downloadProgress.clamp(0, 100);
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 500));
    }

    setState(() {
      isDownloadFinished = true;
      isDownloadStarted = false;
    });
  }
}

IconData updateIcon(int priority) {
  IconData icon = Icons.abc;

  switch (priority) {
    case 1:
      icon = Icons.warning_rounded;
      break;
    case 2:
      icon = Icons.shield_rounded;
      break;
    case 3:
      icon = Icons.dangerous;
      break;
  }

  return icon;
}
