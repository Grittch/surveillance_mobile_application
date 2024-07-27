import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/features/drawer/presentation/riverpod/drawer_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';

class DrawerScreen extends ConsumerStatefulWidget {
  const DrawerScreen({super.key});

  @override
  ConsumerState<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends ConsumerState<DrawerScreen> {
  List<List<dynamic>> options = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    options = [
      [Icons.home_rounded, "Home", "H O M E", true],
      [Icons.favorite, AppLocalizations.of(context)?.drawer_favorites ?? '', AppLocalizations.of(context)?.page_title_favorites ?? '', false],
      [Icons.tune, AppLocalizations.of(context)?.drawer_configure ?? '', AppLocalizations.of(context)?.page_title_configure ?? '', false],
      [Icons.update, AppLocalizations.of(context)?.drawer_updates ?? '', AppLocalizations.of(context)?.page_title_updates ?? '', false],
      [
        Icons.account_circle_rounded,
        AppLocalizations.of(context)?.drawer_profile ?? '',
        AppLocalizations.of(context)?.page_title_profile ?? '',
        false
      ],
      [Icons.color_lens_rounded, AppLocalizations.of(context)?.drawer_aspect ?? '', AppLocalizations.of(context)?.page_title_aspect ?? '', false],
      [
        Icons.notifications_active_rounded,
        AppLocalizations.of(context)?.drawer_notifications ?? '',
        AppLocalizations.of(context)?.page_title_notifications ?? '',
        false
      ],
      [
        Icons.question_answer_rounded,
        AppLocalizations.of(context)?.drawer_contactus ?? '',
        AppLocalizations.of(context)?.page_title_contact_us ?? '',
        false
      ],
      [Icons.logout_rounded, AppLocalizations.of(context)?.drawer_exit ?? '', "", false],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = ref.watch(screenSizeProvider);
    final textScaleFactor = size.width / 400;

    void activeOption(int index) {
      for (int i = 0; i < options.length; i++) {
        options[i][3] = (i == index);
      }
    }

    List<Widget> buildOptionsWidget() {
      List<Widget> optionsWidget = [];

      optionsWidget.add(
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            AppLocalizations.of(context)!.drawer_welcome,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22 * textScaleFactor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      for (int i = 0; i < options.length; i++) {
        if (i == 0 || i == 5 || i == 8) {
          optionsWidget.add(
            Divider(
              color: const Color.fromARGB(100, 255, 255, 255),
              height: size.height * 0.06,
              indent: 24,
              endIndent: MediaQuery.of(context).size.height / 5,
            ),
          );
        }

        optionsWidget.add(
          Column(
            children: [
              Options(
                icon: options[i][0],
                text: options[i][1],
                onTap: () {
                  setState(() {
                    activeOption(i);
                  });

                  ref.read(drawerProvider.notifier).onIndexChanged(index: i, pageTitle: options[i][2]);
                },
                isActive: options[i][3],
                screenHeight: size.height,
                screenWidth: size.width,
              ),
              SizedBox(
                height: i != 4 && i != 7 ? 15 : 0,
              ),
            ],
          ),
        );
      }

      return optionsWidget;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.08,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildOptionsWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Options extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isActive;
  final double screenHeight;
  final double screenWidth;
  final Function() onTap;

  const Options({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.isActive,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = screenWidth / 400;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 24),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        height: screenHeight * 0.05,
        width: 250,
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? const Color.fromARGB(255, 178, 178, 178) : Colors.white,
              size: textScaleFactor * 24,
            ),
            SizedBox(
              width: screenWidth * 0.05,
            ),
            Text(
              text,
              style: TextStyle(
                color: isActive ? const Color.fromARGB(255, 178, 178, 178) : Colors.white,
                fontSize: textScaleFactor * 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
