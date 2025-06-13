import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_nti/widgets/temp_widget.dart';
import '../riverpod/riverpod.dart';

class HomeScreen extends ConsumerWidget {
  final String cityName;
  const HomeScreen(this.cityName, {super.key});

  static bool isFetched = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherRiverpod);
    final TextEditingController cityController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isFetched) {
        ref.read(weatherRiverpod).getCurrentWeather(cityName: cityName);
        isFetched = true;
      }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (weatherState.model != null) {
                ref
                    .read(weatherRiverpod)
                    .getCurrentWeather(cityName: weatherState.model!.cityName);
              }
            },
          ),
          IconButton(
            icon:
                ref.watch(themeRiverpod).isDarkMode
                    ? const Icon(Icons.light_mode)
                    : const Icon(Icons.dark_mode),
            onPressed: () {
              ref.read(themeRiverpod).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final city = cityController.text.trim();
                    if (city.isNotEmpty) {
                      ref
                          .read(weatherRiverpod)
                          .getCurrentWeather(cityName: city);
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: cityController,
              onSubmitted: (city) {
                if (city.trim().isNotEmpty) {
                  ref.read(weatherRiverpod).getCurrentWeather(cityName: city);
                }
              },
            ),
            const SizedBox(height: 20),

            if (weatherState.isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              )
            else if (weatherState.model != null)
              Column(
                children: [
                  // City and Date
                  Text(
                    weatherState.model!.cityName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('EEEE, MMMM d').format(weatherState.model!.date),
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https:${weatherState.model!.image}',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${weatherState.model!.temp.round()}°',
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    weatherState.model!.weatherCondition,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TempWidget(
                        label: 'Max',
                        temp: weatherState.model!.maxTemp,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 20),
                      TempWidget(
                        label: 'Min',
                        temp: weatherState.model!.minTemp,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              )
            else
              const Expanded(
                child: Center(
                  child: Text(
                    'Search for a city to see weather information',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
