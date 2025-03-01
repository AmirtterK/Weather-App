import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/services/Weathers_service.dart';
import '../models/CustomIcons.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  final _weatherService = WeatherService(dotenv.env['OPENWEATHER_API_KEY']!);
  Weather? _weather;
  Timer? _timer;
  _fetchWeather() async {
    String? city = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(city!);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _fetchWeather();
    });
  }

  String getWeatheranimation(String? condition) {
    switch (condition) {
      case 'Clear':
        return isNight ? 'Night' : 'Clear';
      case 'Clouds':
      case 'Mist':
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Fog':
        return 'Clouds';
      case 'Rain':
      case 'Drizzle':
      case 'Shower rain':
        return 'Rain';
      case 'Thunderstorm':
        return 'Thunderstorm';
      case 'Snow':
        return 'Snow';
      default:
        return isNight ? 'Night' : 'Clear';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 7.5),
          child: _weather != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _weather?.city ?? "loading city",
                      style: TextStyle(fontSize: 26),
                    ),
                    Text(
                      DateFormat('EEEE d • HH:mm').format(DateTime.now()),
                    ),
                    Lottie.asset(
                      'assets/${getWeatheranimation(_weather?.condition)}.json',
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      '${_weather?.description}',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      '${_weather?.temperature.round()}°C',
                      style: TextStyle(fontSize: 21),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 6.5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                    ),
                                    Icon(CustomIcon.sun),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Sunrise",
                                          style: TextStyle(
                                            color: isNight
                                                ? Colors.grey.shade300
                                                : Colors.grey.shade800,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('HH:mm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              _weather!.sunrise * 1000,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 9,
                                    ),
                                    Icon(CustomIcon.moon),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Sunset",
                                          style: TextStyle(
                                            color: isNight
                                                ? Colors.grey.shade300
                                                : Colors.grey.shade800,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('HH:mm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              _weather!.sunset * 1000,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                    ),
                                    Icon(CustomIcon.humidity),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Humidity",
                                          style: TextStyle(
                                            color: isNight
                                                ? Colors.grey.shade300
                                                : Colors.grey.shade800,
                                          ),
                                        ),
                                        Text("${_weather!.humidity}%"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 9,
                                    ),
                                    Icon(CustomIcon.pressure),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Pressure",
                                          style: TextStyle(
                                            color: isNight
                                                ? Colors.grey.shade300
                                                : Colors.grey.shade800,
                                          ),
                                        ),
                                        Text("${_weather!.pressure} hPa"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 6,
                    ),
                    Image.asset(
                      isNight
                          ? 'assets/white-cloud.png'
                          : 'assets/black-cloud.png',
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    SpinKitPulse(
                      color: isNight ? Colors.white : Colors.black,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
