class ManageCityModel {
  late String city;
  late String temp;
  late String image;

  ManageCityModel({required this.city, required this.image, required this.temp});

  ManageCityModel.fromJson(Map<String, dynamic> json) {
    city = json["city"];
    temp = json["temp"];
    image = json["image"];
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = {};
    data["city"] = city;
    data["temp"] = temp;
    data["image"] = image;
    return data;
  }
}