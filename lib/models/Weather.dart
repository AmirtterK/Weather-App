
class Weather {
  final String city;
  final double temperature;
  final String condition;
  final String description; 
  final int humidity;
  final int sunrise;
  final int sunset;
  final int pressure;
  Weather(
      {required this.city, required this.temperature, required this.condition,required this.description,required this.humidity,required this.sunrise,required this.sunset,required this.pressure});
  factory Weather.fromJson(Map<String, dynamic> json) {
     return Weather(
        city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      humidity: json["main"]['humidity'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      pressure: json['main']['pressure']
      );
  }
}
