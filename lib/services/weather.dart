import '../utilities/constants.dart';
import 'location.dart';
import 'networking.dart';

class WeatherModel {
  late double temp;
  late int weatharId;
  late String name;


Future< void >getWeatherByCityName(String cityNameInput)async{
  
Map<String,dynamic> weatherCityInfo = await NetworkHelper(url: 'https://api.openweathermap.org/data/2.5/weather?q=$cityNameInput&appid=$KApiKey&units=metric').getData();

temp=weatherCityInfo["main"]["temp"]+0.0;
weatharId=weatherCityInfo["weather"][0]["id"];
name=weatherCityInfo["name"];
}

  

    Future< void >getCurrentLocationWeather()async{
  Location location=Location();
  await location.getCurrentLocation();
Map<String,dynamic> weatherinfo = await NetworkHelper(url: 'https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$KApiKey&units=metric').getData();

temp=weatherinfo["main"]["temp"];
weatharId=weatherinfo["weather"][0]["id"];
name=weatherinfo["name"];
}


  String getWeatherIcon() {
    if (weatharId < 300) {
      return '🌩';
    } else if (weatharId < 400) {
      return '🌧';
    } else if (weatharId < 600) {
      return '☔️';
    } else if (weatharId < 700) {
      return '☃️';
    } else if (weatharId < 800) {
      return '🌫';
    } else if (weatharId == 800) {
      return '☀️';
    } else if (weatharId <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
