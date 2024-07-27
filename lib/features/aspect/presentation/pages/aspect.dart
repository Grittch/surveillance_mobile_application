import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/app_states/locale_states/locale_provider.dart';
import 'package:iot_app_prot1/config/theme/theme_notifier.dart';
import 'package:iot_app_prot1/config/theme/theme_provider.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';
import 'package:iot_app_prot1/shared_widgets/custom_card.dart';
import 'package:iot_app_prot1/shared_widgets/custom_dropdown.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Aspect extends ConsumerStatefulWidget {
  const Aspect({super.key});

  @override
  ConsumerState<Aspect> createState() => _AspectState();
}

class _AspectState extends ConsumerState<Aspect> {
  List<bool> selectedDateFormat = [true, false];
  List<bool> selectedTimeFormat = [true, false];

  List<bool> selectedColor = [false, false, false, false, false, true, false, false];
  List<String> options = [];
  List<String> descriptions = [];
  String selectedLanguage = '🇮🇹 Italiano';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    options = [
      '🇮🇹 Italiano',
      '🇬🇧 English',
      '🇩🇪 Deutsch',
      '🇪🇸 Español',
    ];

    descriptions = [
      AppLocalizations.of(context)!.option_italian,
      AppLocalizations.of(context)!.option_english,
      AppLocalizations.of(context)!.option_german,
      AppLocalizations.of(context)!.option_spanish,
    ];
  }

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    bool isDarkModeEnabled = await _loadDarkModePreference();
    if (isDarkModeEnabled) {
      ref.read(appThemeStateNotifier).setDarkTheme();
    } else {
      ref.read(appThemeStateNotifier).setLightTheme();
    }

    String savedLanguage = await _loadLanguagePreference();
    setState(() {
      selectedLanguage = _getLanguageLabel(savedLanguage);
    });
  }

  Future<void> _saveDarkModePreference(bool isDarkModeEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkModeEnabled', isDarkModeEnabled);
  }

  Future<bool> _loadDarkModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkModeEnabled') ?? false;
  }

  Future<String> _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLanguage') ?? 'it';
  }

  String _getLanguageLabel(String languageCode) {
    switch (languageCode) {
      case 'it':
        return '🇮🇹 Italiano';
      case 'en':
        return '🇬🇧 English';
      case 'de':
        return '🇩🇪 Deutsch';
      case 'es':
        return '🇪🇸 Español';
      default:
        return '🇬🇧 English';
    }
  }

  void onColorSelected(int index, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('backgroundColor', color.value);

    setState(() {
      for (int i = 0; i < selectedColor.length; i++) {
        selectedColor[i] = (i == index);
      }
    });
    ref.read(colorProvider.notifier).onColorChanged(color);
  }

  List<Color> colorList = [
    const Color.fromARGB(255, 172, 123, 123),
    const Color.fromARGB(255, 172, 149, 123),
    const Color.fromARGB(255, 169, 172, 123),
    const Color.fromARGB(255, 132, 172, 123),
    const Color.fromARGB(255, 123, 172, 154),
    const Color.fromARGB(255, 123, 151, 172),
    const Color.fromARGB(255, 138, 123, 172),
    const Color.fromARGB(255, 172, 123, 165),
  ];

  void onFormatSelected(int index, List<bool> isSelected) async {
    setState(() {
      if (index == 0) {
        isSelected[0] = true;
        isSelected[1] = false;
      } else {
        isSelected[0] = false;
        isSelected[1] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    final size = ref.watch(screenSizeProvider);
    final textScaleFactor = size.width / 400;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomCard(children: [
          SwitchListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              "Dark Mode:",
              style: TextStyle(fontSize: 18 * textScaleFactor),
            ),
            value: appThemeState.isDarkModeEnabled,
            onChanged: (enabled) async {
              if (enabled) {
                appThemeState.setDarkTheme();
              } else {
                appThemeState.setLightTheme();
              }
              await _saveDarkModePreference(enabled);
            },
          ),
        ]),
        CustomCard(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                "${AppLocalizations.of(context)!.label_theme}:",
                style: TextStyle(
                  fontSize: 18 * textScaleFactor,
                ),
              ),
            ),
            Container(
              height: size.height * 0.2,
              width: double.infinity,
              child: GridView.count(
                crossAxisCount: 4,
                children: List.generate(
                  selectedColor.length,
                  (index) => ColorCard(
                    color: colorList[index],
                    selectedColor: selectedColor[index],
                    onTap: () => onColorSelected(index, colorList[index]),
                    width: size.width,
                    heigth: size.height,
                  ),
                ),
              ),
            ),
          ],
        ),
        CustomDropdown(
            label: "${AppLocalizations.of(context)!.label_language}:",
            options: options,
            descriptions: descriptions,
            selectedDevice: selectedLanguage,
            onChanged: (String newValue) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              Locale newLocale;
              switch (newValue) {
                case '🇮🇹 Italiano':
                  newLocale = const Locale('it');
                  break;
                case '🇬🇧 English':
                  newLocale = const Locale('en');
                  break;
                case '🇩🇪 Deutsch':
                  newLocale = const Locale('de');
                  break;
                case '🇪🇸 Español':
                  newLocale = const Locale('es');
                  break;
                default:
                  newLocale = const Locale('en');
              }
              await prefs.setString('selectedLanguage', newLocale.languageCode);
              setState(() {
                selectedLanguage = newValue;
              });
              ref.read(localeProvider.notifier).setLocale(newLocale);
            }),
        CustomCard(
          children: [
            CustomToggleButtons(
              isSelected: selectedDateFormat,
              textOne: "DD/MM/YYYY",
              textTwo: "MM/DD/YYYY",
              label: "${AppLocalizations.of(context)!.label_date_format}:",
              onPressed: (int index) {
                onFormatSelected(index, selectedDateFormat);
              },
            ),
          ],
        ),
        CustomCard(
          children: [
            CustomToggleButtons(
              isSelected: selectedTimeFormat,
              textOne: "24H",
              textTwo: "12H",
              label: "${AppLocalizations.of(context)!.label_time_format}:",
              onPressed: (int index) {
                onFormatSelected(index, selectedTimeFormat);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class CustomToggleButtons extends StatelessWidget {
  const CustomToggleButtons({
    super.key,
    required this.isSelected,
    required this.onPressed,
    required this.textOne,
    required this.textTwo,
    required this.label,
  });

  final List<bool> isSelected;
  final Function(int index) onPressed;
  final String textOne;
  final String textTwo;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        ToggleButtons(
          borderRadius: BorderRadius.circular(16),
          isSelected: isSelected,
          onPressed: onPressed,
          children: [
            Container(
              width: 125,
              child: Center(
                child: Text(textOne),
              ),
            ),
            Container(
              width: 125,
              child: Center(
                child: Text(textTwo),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ColorCard extends ConsumerStatefulWidget {
  final Color color;
  final bool selectedColor;
  final VoidCallback onTap;
  final double width;
  final double heigth;

  const ColorCard({
    super.key,
    required this.color,
    required this.selectedColor,
    required this.onTap,
    required this.width,
    required this.heigth,
  });

  @override
  ConsumerState<ColorCard> createState() => _ColorCardState();
}

class _ColorCardState extends ConsumerState<ColorCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: widget.color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
