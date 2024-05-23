class WeatherModel {
  late String cod;
  late String message;
  late int cnt;
  late List<Temp> list;
  late City city;

  WeatherModel({required this.cnt, required this.cod, required this.message});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    cod = json["cod"].toString();
    message = json["message"].toString();
    cnt = json["cnt"];

    if (json["list"] != null) {
      list = <Temp>[];
      json["list"].forEach((value) {
        list.add(Temp.fromJson(value));
      });
    }
    city = City.fromJson(json["city"]);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    data['city'] = city.toJson();
    data['list'] = list.map((e) => e.toJson()).toList();
    return data;
  }
}

class Temp {
  late int dt;
  late Main main;
  late List<Weather> weather;
  late Wind wind;
  late String visibility;
  late String dttxt;

  Temp(
      {required this.dt,
      required this.dttxt,
      required this.main,
      required this.visibility,
      required this.weather,
      required this.wind});

  Temp.fromJson(Map<String, dynamic> json) {
    dt = json["dt"];
    main = Main.fromJson(json["main"]);
    if (json["weather"] != null) {
      weather = <Weather>[];
      json["weather"].forEach((values) {
        weather.add(Weather.fromJson(values));
      });
    }
    wind = Wind.fromJson(json["wind"]);
    visibility = json["visibility"].toString();
    dttxt = json["dt_txt"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['main'] = main.toJson();
    data['weather'] = weather.map((e) => e.toJson()).toList();
    data['wind'] = wind.toJson();
    data['visibility'] = visibility;
    data['dt_txt'] = dttxt;
    return data;
  }
}

class Weather {
  late int id;
  late String main;

  Weather({required this.id, required this.main});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    main = json["main"];
  }

  Map<String, dynamic> toJson() => {'id': id, 'main': main};
}

class Main {
  late String temp;
  late String pressure;
  late String seaLevel;
  late String grndLevel;
  late String humidity;
  late String feellike;

  Main(
      {required this.feellike,
      required this.temp,
      required this.pressure,
      required this.seaLevel,
      required this.grndLevel,
      required this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    feellike = json["feels_like"].toString();
    temp = json["temp"].toString();
    pressure = json['pressure'].toString();
    seaLevel = json['sea_level'].toString();
    grndLevel = json['grnd_level'].toString();
    humidity = json['humidity'].toString();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['feels_like'] = feellike;
    data['temp'] = temp;
    data['pressure'] = pressure;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    data['humidity'] = humidity;
    return data;
  }
}

class Wind {
  late String speed;
  late String degree;

  Wind({required this.speed, required this.degree});
  Wind.fromJson(Map<String, dynamic> json) {
    speed = json["speed"].toString();
    degree = json["deg"].toString();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = degree;
    return data;
  }
}

class City {
  late int id;
  late String name;
  late int sunrise;
  late int sunset;

  City({
    required this.id,
    required this.name,
    required this.sunrise,
    required this.sunset,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    sunrise = json["sunrise"];
    sunset = json["sunset"];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
