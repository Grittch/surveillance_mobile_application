import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/features/drawer/presentation/riverpod/drawer_states.dart';

class DrawerNotifier extends StateNotifier<DrawerStates> {
  DrawerNotifier() : super(const DrawerStates());

  void onIndexChanged({int? index, String? pageTitle, double? xOffset, double? yOffset}) {
    state = state.copyWith(index: index, pageTitle: pageTitle, xOffset: xOffset, yOffset: yOffset);
  }
}

final drawerProvider = StateNotifierProvider<DrawerNotifier, DrawerStates>((ref) => DrawerNotifier());
