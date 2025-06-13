import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_nti/config/themes/app_theme.dart';
import 'package:weather_nti/riverpod/riverpod.dart';
import 'package:weather_nti/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final container = ProviderContainer();
  final position = await container.read(weatherRiverpod.notifier).getPosition();
  final cityName = await container
      .read(weatherRiverpod.notifier)
      .getCityFromPosition(position);

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: MyApp(cityName: cityName),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final String cityName;
  const MyApp({super.key, required this.cityName});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(cityName),
      theme: ref.watch(themeRiverpod).themeData,
      darkTheme: AppTheme.darkThemeMode,
      themeMode: ThemeMode.system,
    );
  }
}
