import 'package:flutter/material.dart';


//import '../services/networking.dart';
import '../services/weather.dart';
import '../utilities/constants.dart';
import 'location_screen.dart';


class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  CityScreenState createState() => CityScreenState();
}

class CityScreenState extends State<CityScreen> {

 
  String? cityNameInput;
  
 void getWeatherData()async{
 WeatherModel weather=WeatherModel();
 await weather.getWeatherByCityName(cityNameInput??"london");

  if (mounted){
Navigator.push(context, MaterialPageRoute(builder: (context){
  return LocationScreen(weatharData: weather);
}));}
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
              const Text("Enter the name of the city you want",style: TextStyle(
                fontSize: 30.0,
  fontFamily: 'Spartan MB',
  color: Colors.white,
  
  
  
  ) ,
  textAlign: TextAlign.center,),

   TextField(

    style: const TextStyle(color: Colors.white,fontSize: 30.0,
  fontFamily: 'Spartan MB',),
  onChanged: (value) {
    cityNameInput=value;
   //print(cityNameInput);
    },
  
  ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: null,
              ),
              TextButton(
                onPressed: () {


getWeatherData();
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
