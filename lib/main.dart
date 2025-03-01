import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/pages/Weather_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

bool isNight = false;

Future<void> main() async {
  await dotenv.load(fileName: 'lib/services/.env');
  isNight = (DateTime.now().hour >= 21 || DateTime.now().hour < 5);
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isNight ? Brightness.dark : Brightness.light,
        useMaterial3: true,
      ),
      home: const Weatherpage(),
    );
  }
}
