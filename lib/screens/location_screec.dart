// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables, library_private_types_in_public_api, prefer_const_constructors_in_immutables, avoid_print, annotate_overrides, override_on_non_overriding_member, unused_local_variable, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:weitherdetector/screens/city_screen.dart';
import 'package:weitherdetector/servics/weather.dart';
import 'package:weitherdetector/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  WeatherModel weather = WeatherModel();

  int? temperature;
  String? weatherIcon;
  String? cityname;
  String? weatherMessage;
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  void updateUi(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'error';
        weatherMessage = 'unable to get weather data';
        cityname = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityname = weatherData['name'];
    });
  }

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
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUi(weatherData);
                    },
                    icon: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.fromLTRB(20, 20, 40, 0),
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                        await weather.getCityWeather(typedName);
                        updateUi(weatherData);
                      }
                    },
                    icon: Icon(
                      Icons.location_disabled_rounded,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon.toString(),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityname!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
