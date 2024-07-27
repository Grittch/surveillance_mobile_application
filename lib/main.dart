import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/app_states/locale_states/locale_provider.dart';
import 'package:iot_app_prot1/config/theme/theme.dart';
import 'package:iot_app_prot1/config/theme/theme_notifier.dart';
import 'package:iot_app_prot1/config/theme/theme_provider.dart';
import 'package:iot_app_prot1/core/utils/screen_size/screen_size_provider.dart';
import 'package:iot_app_prot1/features/drawer/presentation/pages/drawer_screen.dart';
import 'package:iot_app_prot1/l10n/l10n.dart';
import 'package:iot_app_prot1/page_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

final themeProvider = StateProvider<bool>((ref) => true);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final container = ProviderContainer();
  await loadBackgroundColor(container);
  await _signInAnonymously();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Future<void> loadBackgroundColor(ProviderContainer container) async {
  final prefs = await SharedPreferences.getInstance();
  final colorValue = prefs.getInt('backgroundColor');

  if (colorValue != null) {
    final color = Color(colorValue);
    container.read(colorProvider.notifier).onColorChanged(color);
  }
}

Future<void> loadLanguagePreference(ProviderContainer container) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedLanguageCode = prefs.getString('selectedLanguage');
  if (savedLanguageCode != null) {
    Locale newLocale = Locale(savedLanguageCode);

    container.read(localeProvider.notifier).setLocale(newLocale);
  } else {
    container.read(localeProvider.notifier).setLocale(const Locale('en'));
  }
}

Future<void> _signInAnonymously() async {
  try {
    await FirebaseAuth.instance.signInAnonymously();
    print("Autenticazione anonima riuscita.");
  } catch (e) {
    print("Errore durante l'autenticazione anonima: $e.");
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    final primaryColor = ref.watch(colorProvider);

    final ThemeData theme = lightTheme.copyWith(
      colorScheme: lightTheme.colorScheme.copyWith(
        primary: primaryColor,
        secondary: primaryColor,
        tertiary: primaryColor,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final Locale? appLocale = ref.watch(localeProvider);

    return ScreenSizeProviderWidget(
      child: MaterialApp(
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: appLocale,
        debugShowCheckedModeBanner: false,
        theme: appThemeState.isDarkModeEnabled ? darkTheme : theme,
        home: const Material(
          child: Stack(
            children: [
              DrawerScreen(),
              PageManager(),
            ],
          ),
        ),
      ),
    );
  }
}
