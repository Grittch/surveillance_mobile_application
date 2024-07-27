import 'package:flutter/material.dart';

class MonitoringCard extends StatelessWidget {
  final String type;
  final int number;
  final double width;
  final double height;

  const MonitoringCard({super.key, required this.type, required this.number, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = width / 400;
    return Container(
      width: width * 0.45,
      height: height * 0.12,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                type,
                style: TextStyle(fontSize: 22 * textScaleFactor, color: Colors.white),
              ),
              Text(
                number.toString(),
                style: TextStyle(fontSize: 20 * textScaleFactor, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
