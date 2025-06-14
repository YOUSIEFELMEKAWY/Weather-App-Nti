# 🌦️ Weather App – NTI

This is a simple and elegant Flutter weather app developed during my training at the **National Telecommunication Institute (NTI)**. The app provides real-time weather updates and dynamically changes its theme based on the weather condition.

---

## 📽️ Demo
[Screen_recording_20250613_072352.webm](https://github.com/user-attachments/assets/d1bfbb41-a05e-40a0-81b7-5fe380390ea9)
![Screenshot_20250613_072654](https://github.com/user-attachments/assets/4f6d1e58-1740-47c3-8eea-3cd5c9252ace)
![Screenshot_20250613_072643](https://github.com/user-attachments/assets/58859e0a-c706-4592-8ffe-1c8a44e282e1)

---

## ✨ Features

- 🌍 Search for any city's weather
- 🌡️ Display of temperature, weather condition, and city name
- 🎨 Light & Dark Mode
- 🚫 Graceful error handling for invalid input or no connection
- 💡 Clean and simple user interface

---

## 🛠️ Tech Stack

- **Flutter**
- **Riverpod** – for state and theme management
- **Dio** – for handling API requests
- **OpenWeatherMap API** – for weather data

---

## 📦 Packages Used

```yaml
dependencies:
  flutter:
    sdk: flutter

  
  cupertino_icons: ^1.0.8
  dio: ^5.8.0+1
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1
  intl: ^0.18.1
  geolocator: ^14.0.1
  geocoding: ^4.0.0
  shared_preferences: ^2.5.3
