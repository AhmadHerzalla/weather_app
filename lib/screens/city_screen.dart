import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

import '../services/weather.dart';
import '../utilities/constants.dart';
import 'location_screen.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  CityScreenState createState() => CityScreenState();
}

class CityScreenState extends State<CityScreen> {
  String? cityNameInputl = "Indonesia";

  void getWeatherData(String cityNameInput) async {
    WeatherModel weather = WeatherModel();
    await weather.getWeatherByCityName(cityNameInput);

    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(weatharData: weather);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              const Text(
                "Enter the name of the city you want",
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Spartan MB',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              CountryListPick(

                  // if you need custome picker use this
                  // pickerBuilder: (context, CountryCode countryCode){
                  //   return Row(
                  //     children: [
                  //       Image.asset(
                  //         countryCode.flagUri,
                  //         package: 'country_list_pick',
                  //       ),
                  //       Text(countryCode.code),
                  //       Text(countryCode.dialCode),
                  //     ],
                  //   );
                  // },

                  // To disable option set to false
                  theme: CountryTheme(
                    isShowFlag: true,
                    isShowTitle: true,
                    isShowCode: true,
                    isDownIcon: true,
                    showEnglishName: true,
                  ),
                  // Set default value
                  initialSelection: '+62',

                  // or
                  // initialSelection: 'US'
                  onChanged: (CountryCode? code) {
                    cityNameInputl = code!.name;
                    // print(code.code);
                    // print(code.dialCode);
                    // print(code.flagUri);
                  },
                  // Whether to allow the widget to set a custom UI overlay
                  useUiOverlay: true,
                  // Whether the country list should be wrapped in a SafeArea
                  useSafeArea: true),
              // TextField(
              //   style: const TextStyle(
              //     color: Colors.white,
              //     fontSize: 30.0,
              //     fontFamily: 'Spartan MB',
              //   ),
              //   onChanged: (value) {
              //     cityNameInput = value;
              //     //print(cityNameInput);
              //   },
              // ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: null,
              ),
              TextButton(
                onPressed: () {
                  print("---------------------");
                  print(cityNameInputl);
                  getWeatherData(cityNameInputl ?? "");
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
