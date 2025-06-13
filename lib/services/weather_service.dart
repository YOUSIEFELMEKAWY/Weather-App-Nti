import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';

class WeatherService extends ChangeNotifier {
  final dio = Dio();
  WeatherModel? model;
  String baseUrl = 'https://api.weatherapi.com/v1';
  String apiKey = '7dce73305660464ab9d143243231402';
  bool isLoading = false;
  String? errorMessage;

  Future<void> getCurrentWeather({required String cityName}) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      Response response = await dio.get(
        '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1&aqi=no&alerts=no',
      );

      model = WeatherModel.fromJson(response.data);
      errorMessage = null;
    } on DioException catch (e) {
      errorMessage = e.response?.data['error']['message'] ??
          'There was an error, Try again later.';
      log(errorMessage!);
    } catch (e) {
      errorMessage = 'There was an error, Try again later.';
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getCityFromPosition(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      return placemarks.first.locality ?? 'Unknown City';
    } catch (e) {
      throw Exception('Could not get city name');
    }
  }
}
