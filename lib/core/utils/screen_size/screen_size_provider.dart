import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';

class ScreenSizeProviderWidget extends ConsumerWidget {
  final Widget child;

  const ScreenSizeProviderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return ProviderScope(
      overrides: [
        screenSizeProvider.overrideWithValue(size),
      ],
      child: child,
    );
  }
}
