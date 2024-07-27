import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';

class Notifications extends ConsumerStatefulWidget {
  const Notifications({super.key});

  @override
  ConsumerState<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends ConsumerState<Notifications> {
  List<bool> filterIsSelected = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  List<List<dynamic>> checkboxes = [
    ["Push", true],
    ["Email", false],
    ["SMS", false],
  ];

  List<bool> switches = [true, false];

  @override
  Widget build(BuildContext context) {
    final size = ref.watch(screenSizeProvider);
    final textScaleFactor = size.width / 400;
    List<String?> filters = [
      AppLocalizations.of(context)?.chip_glass,
      AppLocalizations.of(context)?.chip_shout,
      AppLocalizations.of(context)?.chip_siren,
      AppLocalizations.of(context)?.chip_shot,
      AppLocalizations.of(context)?.chip_explosion,
      AppLocalizations.of(context)?.chip_alarm,
      AppLocalizations.of(context)?.chip_honk,
      AppLocalizations.of(context)?.chip_car,
      AppLocalizations.of(context)?.chip_voices,
      AppLocalizations.of(context)?.chip_whistle,
      AppLocalizations.of(context)?.chip_bang,
      AppLocalizations.of(context)?.chip_whispers,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text(
            "${AppLocalizations.of(context)!.label_notifications_on}:",
            style: TextStyle(fontSize: 18 * textScaleFactor),
          ),
          value: switches[0],
          onChanged: (bool value) {
            setState(() {
              switches[0] = value;
            });
          },
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        SizedBox(
          height: size.height * 0.012,
        ),
        Text(
          "${AppLocalizations.of(context)!.label_dangerous_sounds}:",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18 * textScaleFactor,
          ),
        ),
        Container(
          height: 300,
          width: double.infinity,
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 2.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            children: List.generate(
              filters.length,
              (index) => SoundFilters(
                isSelected: filterIsSelected[index],
                label: filters[index]!,
                onSelected: (value) {
                  setState(() {
                    filterIsSelected[index] = !filterIsSelected[index];
                  });
                },
              ),
            ),
          ),
        ),
        Text(
          "${AppLocalizations.of(context)!.label_notification_type}:",
          style: TextStyle(
            fontSize: 18 * textScaleFactor,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(checkboxes.length, (index) {
            return CheckboxListTile(
              title: Text(checkboxes[index][0]),
              value: checkboxes[index][1],
              onChanged: (newValue) {
                setState(() {
                  checkboxes[index][1] = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
        ),
      ],
    );
  }
}

class SoundFilters extends StatelessWidget {
  final String label;
  final Function(bool value) onSelected;
  const SoundFilters({
    super.key,
    required this.isSelected,
    required this.label,
    required this.onSelected,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selectedColor: Theme.of(context).colorScheme.primary,
      selected: isSelected,
      onSelected: onSelected,
    );
  }
}
