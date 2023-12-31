import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';

import '../services/weather.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final WeatherModel weatharData;
  const LocationScreen({super.key, required this.weatharData});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  void backToGaza() async {
    WeatherModel back = WeatherModel();
    await back.getCurrentLocationWeather();
    setState(() {
      temp = back.temp;
      descrebtion = back.getMessage();
      cityName = back.name;
      icon = back.getWeatherIcon();
    });
  }

  late double temp;
  late String cityName;
  late String icon;
  late String descrebtion;

  final ImageProvider _image =
      const AssetImage('images/location_background.jpg');
  final ImageProvider _networkImage =
      const NetworkImage('https://source.unsplash.com/random/?nature,day');
  bool isloaded = false;

  void updateUi() {
    temp = widget.weatharData.temp;
    cityName = widget.weatharData.name;
    icon = widget.weatharData.getWeatherIcon();
    descrebtion = widget.weatharData.getMessage();
  }

  void getImageProvider() {
    _networkImage
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      setState(() {
        isloaded = true;
      });
    }));
  }

  @override
  initState() {
    updateUi();
    super.initState();
    getImageProvider();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.weatharData);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                // image: AssetImage('images/location_background.jpg'),
                image: !isloaded ? _image : _networkImage,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: const BoxConstraints.expand(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.0)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  // color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
//Navigator.push(context, MaterialPageRoute(builder:(context) => LoadingScreen(),));
                        backToGaza();
                      },
                      child: const Icon(
                        Icons.near_me,
                        size: 50.0,
                        color: kSecondaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CityScreen(),
                            ));
                      },
                      child: const Icon(
                        Icons.location_city,
                        size: 50.0,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      icon,
                      style: TextStyle(fontSize: 60),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "${temp.toInt()}",
                          style: kTempTextStyle,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 10),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 7,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                  // shape: BoxShape.circle,
                                  ),
                            ),
                            const Text(
                              'now',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'Spartan MB',
                                letterSpacing: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Text(
                  descrebtion,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24.0, top: 24),
                child: Text(
                  cityName,
                  textAlign: TextAlign.right,
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
