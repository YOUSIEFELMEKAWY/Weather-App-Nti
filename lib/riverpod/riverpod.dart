import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_nti/services/weather_service.dart';
import '../services/theme_service.dart';

final weatherRiverpod = ChangeNotifierProvider<WeatherService>((ref) {
  return WeatherService();
});

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences should be overridden in main()');
});

final themeRiverpod = ChangeNotifierProvider<ThemeRiverpod>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return ThemeRiverpod(prefs: prefs);
});
