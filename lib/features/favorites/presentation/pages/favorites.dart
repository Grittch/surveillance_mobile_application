import 'package:flutter/material.dart';
import 'package:iot_app_prot1/shared_widgets/detection_list.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return const DetectionList(showOnlyFavorites: true);
  }
}
