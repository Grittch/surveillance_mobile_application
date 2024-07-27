import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/features/drawer/presentation/riverpod/drawer_notifier.dart';
import 'package:iot_app_prot1/app_states/nav_states/nav_notifier.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';
import 'package:iot_app_prot1/features/configuration/presentation/pages/configuration.dart';
import 'package:iot_app_prot1/features/favorites/presentation/pages/favorites.dart';
import 'package:iot_app_prot1/features/profile/presentation/pages/profile.dart';
import 'package:iot_app_prot1/features/contact_us/presentation/pages/contact_us.dart';
import 'package:iot_app_prot1/features/home/presentation/pages/home.dart';
import 'package:iot_app_prot1/features/notifications/presentation/pages/notifications.dart';
import 'package:iot_app_prot1/features/aspect/presentation/pages/aspect.dart';
import 'package:iot_app_prot1/features/updates/presentation/pages/updates.dart';
import 'package:iot_app_prot1/features/home/presentation/widgets/bottom_app_bar.dart';

class PageManager extends ConsumerStatefulWidget {
  const PageManager({super.key});

  @override
  ConsumerState<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends ConsumerState<PageManager> {
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    var navIndex = ref.watch(navProvider);
    var drawerIndex = ref.watch(drawerProvider);
    final size = ref.watch(screenSizeProvider);

    final List<Widget> widgetOptions = <Widget>[
      Home(index: navIndex.index),
      const Favorites(),
      const Configuration(),
      const Updates(),
      const Profile(),
      const Aspect(),
      const Notifications(),
      const ContactUs(),
    ];

    return AnimatedContainer(
      transform: Matrix4.translationValues(drawerIndex.xOffset, drawerIndex.yOffset, 0)..scale(drawerIndex.isDrawerOpen ? 0.85 : 1.0),
      duration: const Duration(
        milliseconds: 150,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: drawerIndex.isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
        color: Colors.white,
      ),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: Text(drawerIndex.pageTitle),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                drawerIndex.isDrawerOpen
                    ? {ref.read(drawerProvider.notifier).onIndexChanged(xOffset: 0, yOffset: 0)}
                    : {ref.read(drawerProvider.notifier).onIndexChanged(xOffset: 300, yOffset: 80)};

                FocusManager.instance.primaryFocus?.unfocus();
              },
              icon: Icon(drawerIndex.isDrawerOpen ? Icons.close : Icons.menu)),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        bottomNavigationBar: drawerIndex.index == 0
            ? GBottomNavigationBar(
                index: navIndex.index,
                onTabChange: (value) {
                  ref.read(navProvider.notifier).onIndexChanged(value);
                },
                onPressed: () {})
            : null,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Material(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.05),
            child: GestureDetector(
              onTap: () {
                if (drawerIndex.isDrawerOpen) {
                  ref.read(drawerProvider.notifier).onIndexChanged(xOffset: 0, yOffset: 0);
                }
                ;
              },
              child: AbsorbPointer(
                absorbing: drawerIndex.isDrawerOpen,
                child: widgetOptions[drawerIndex.index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
