// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_local_variable, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weitherdetector/screens/location_screec.dart';
import 'package:weitherdetector/servics/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? longitude;
  double? latitude;

  @override
  void initState() {
    print('loading screen init calling');
    getLocationData();
    super.initState();
  }

  void getLocationData() async {
    //  print('weather data' + weatherData.toString());

    var weatherDAta = await WeatherModel().getLocationWeather();

    var push = Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherDAta,
      );
    }));
  } // ignore: unnecessary_brace_in_string_interps

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
              'assets/weather.jpg',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: Center(
            child: SpinKitSpinningLines(
              color: Colors.black,
              size: 100,
            )),
      ),
    );
  }
}
