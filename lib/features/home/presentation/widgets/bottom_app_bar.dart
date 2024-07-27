import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GBottomNavigationBar extends ConsumerStatefulWidget {
  final int index;
  final void Function(int) onTabChange;
  final void Function() onPressed;
  const GBottomNavigationBar({super.key, required this.index, required this.onTabChange, required this.onPressed});

  @override
  ConsumerState<GBottomNavigationBar> createState() => _GBottomNavigationBarState();
}

class _GBottomNavigationBarState extends ConsumerState<GBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final size = ref.watch(screenSizeProvider);
    final textSclareFactor = size.width / 400;
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.01, vertical: size.height * 0.015),
        child: GNav(
          backgroundColor: Theme.of(context).colorScheme.primary,
          color: Colors.white.withOpacity(0.6),
          activeColor: Colors.white,
          tabBackgroundColor: Colors.white.withOpacity(0.25),
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.02, vertical: size.height * 0.015),
          tabBorderRadius: 16.0,
          iconSize: 26 * textSclareFactor,
          selectedIndex: widget.index,
          onTabChange: widget.onTabChange,
          tabs: [
            GButton(
              icon: Icons.multitrack_audio_rounded,
              gap: size.height * 0.01,
              text: AppLocalizations.of(context)!.bottom_appbar_monitoring,
              textSize: 14 * textSclareFactor,
            ),
            GButton(
              icon: Icons.hearing_rounded,
              gap: size.height * 0.01,
              text: AppLocalizations.of(context)!.bottom_appbar_listening,
            ),
            GButton(
              icon: Icons.bar_chart_rounded,
              gap: size.height * 0.01,
              text: AppLocalizations.of(context)!.bottom_appbar_history,
            ),
            GButton(
              icon: Icons.speaker_phone_rounded,
              gap: size.height * 0.01,
              text: AppLocalizations.of(context)!.bottom_appbar_devices,
            ),
          ],
        ),
      ),
    );
  }
}
