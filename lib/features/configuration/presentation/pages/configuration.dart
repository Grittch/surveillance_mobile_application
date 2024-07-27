import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/core/constants/constants.dart';
import 'package:iot_app_prot1/shared_widgets/custom_card.dart';
import 'package:iot_app_prot1/shared_widgets/custom_dropdown.dart';
import 'package:iot_app_prot1/shared_widgets/custom_snackbar.dart';
import 'package:iot_app_prot1/shared_widgets/info_row.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Configuration extends ConsumerStatefulWidget {
  const Configuration({super.key});

  @override
  ConsumerState<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends ConsumerState<Configuration> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  List<String> locations = [];
  late String location;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locations = [
      AppLocalizations.of(context)!.label_kitchen,
      AppLocalizations.of(context)!.label_bedroom,
      AppLocalizations.of(context)!.label_living,
      AppLocalizations.of(context)!.label_office,
      AppLocalizations.of(context)!.label_garage,
    ];

    location = AppLocalizations.of(context)!.label_kitchen;
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? TimeOfDay.now() : _endTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            timePickerTheme: TimePickerThemeData(
              dialHandColor: Theme.of(context).colorScheme.primary,
              dialBackgroundColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.background,
              dayPeriodTextColor: Theme.of(context).colorScheme.primary,
              hourMinuteTextColor: Colors.black,
              hourMinuteColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
      });
    }
  }

  List<String> selectedDevice = ["AGPro", "JSt8iCbiQ5X3pO4hitam"];
  final List<List<String>> _devices = [
    ["AGPro", "AGLite", "AGPortable"],
    ["JSt8iCbiQ5X3pO4hitam", "gxrYnySgquvieboPBySM", "fwzczaIbWvfmJgr1I34s"],
  ];

  @override
  Widget build(BuildContext context) {
    void getLocation(int index) {
      setState(() {
        location = locations[index];
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomDropdown(
          label: "${AppLocalizations.of(context)!.label_devices}:",
          options: _devices[0],
          descriptions: _devices[1],
          icon: Icons.wifi,
          selectedDevice: selectedDevice[0],
          onChanged: (newValue) {
            setState(() {
              selectedDevice[0] = newValue;
            });
          },
        ),
        CustomCard(
          children: [
            Text(
              "${AppLocalizations.of(context)!.label_place}:",
              style: const TextStyle(fontSize: 18.0),
            ),
            IconButtonsRow(getLocation: getLocation),
          ],
        ),
        CustomCard(
          children: [
            Text(
              "${AppLocalizations.of(context)!.label_time_slot}:",
              style: const TextStyle(fontSize: 18.0),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () => _selectTime(context, true),
                        child: Text(
                          AppLocalizations.of(context)!.button_start,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 2),
                    Container(
                      width: 100,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () => _selectTime(context, false),
                        child: Text(
                          AppLocalizations.of(context)!.button_end,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${(_startTime != null) ? _startTime!.format(context) : "--:--"}    /    ${(_endTime != null) ? _endTime!.format(context) : "--:--"}',
                ),
              ],
            ),
          ],
        ),
        CustomCard(
          children: [
            Text(
              "${AppLocalizations.of(context)!.label_summary}:",
              style: const TextStyle(fontSize: 18),
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(label: "DeviceID", value: selectedDevice[1]),
                  InfoRow(label: AppLocalizations.of(context)!.label_device, value: selectedDevice[0]),
                  InfoRow(label: AppLocalizations.of(context)!.label_place, value: location),
                  InfoRow(
                      label: AppLocalizations.of(context)!.label_installation,
                      value: formatDateTime(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch)).toString()),
                  InfoRow(
                      label: AppLocalizations.of(context)!.label_time_slot,
                      value:
                          "${(_startTime != null) ? _startTime!.format(context) : "--:--"} - ${(_endTime != null) ? _endTime!.format(context) : "--:--"}"),
                ],
              ),
            ),
          ],
        ),
        ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.0),
            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
          ),
          onPressed: () async {
            try {
              await ();
              CustomSnackbar.show(context, AppLocalizations.of(context)!.snackbar_configuration_ok,
                  AppLocalizations.of(context)!.snackbar_configuration_ok_descritpion);
            } catch (error) {
              CustomSnackbar.show(context, AppLocalizations.of(context)!.snackbar_configuration_error,
                  AppLocalizations.of(context)!.snackbar_configuration_error_descritpion);
            }
          },
          child: Text(
            AppLocalizations.of(context)!.button_send,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class IconButtonsRow extends StatefulWidget {
  final Function(int index) getLocation;

  const IconButtonsRow({super.key, required this.getLocation});
  @override
  _IconButtonsRowState createState() => _IconButtonsRowState();
}

class _IconButtonsRowState extends State<IconButtonsRow> {
  int _selectedIndex = -1;

  final icons = [
    Icons.kitchen,
    Icons.bed,
    Icons.tv,
    Icons.cases_outlined,
    Icons.garage_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(icons.length, (index) {
        return IconButtonWithBackground(
          isSelected: _selectedIndex == index,
          iconData: icons[index],
          onTap: () {
            setState(() {
              _selectedIndex = index;
              widget.getLocation(_selectedIndex);
            });
          },
        );
      }),
    );
  }
}

class IconButtonWithBackground extends StatelessWidget {
  final bool isSelected;
  final IconData iconData;
  final VoidCallback onTap;

  const IconButtonWithBackground({
    super.key,
    required this.isSelected,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.75) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(
          iconData,
          size: 24.0,
        ),
      ),
    );
  }
}
