import 'package:iot_app_prot1/features/home/presentation/widgets/individual_bar.dart';

class BarData {
  List<Map<String, dynamic>> weeklyDetection;

  BarData({required this.weeklyDetection});

  List<IndividualBar> barData = [];
  void initializeBarData() {
    barData = [];
    for (int i = 0; i < weeklyDetection.length; i++) {
      barData.add(
        IndividualBar(
          x: weeklyDetection[i]["date"].toInt(),
          y: weeklyDetection[i]["value"],
        ),
      );
    }
  }
}
