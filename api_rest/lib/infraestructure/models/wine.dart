// dart
import 'dart:convert';

class Wine {
  final String winery;
  final String wine;
  final Rating rating;
  final String location;
  final String image;
  final int id;

  Wine({
    required this.winery,
    required this.wine,
    required this.rating,
    required this.location,
    required this.image,
    required this.id,
  });

  factory Wine.fromJson(Map<String, dynamic> json) => Wine(
    winery: json["winery"] ?? "",
    wine: json["wine"] ?? "",
    rating: Rating.fromJson(json["rating"] ?? {}),
    location: json["location"] ?? "",
    image: json["image"] ?? "",
    id: json["id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "winery": winery,
    "wine": wine,
    "rating": rating.toJson(),
    "location": location,
    "image": image,
    "id": id,
  };
}

class Rating {
  final double average;
  final int reviews;

  Rating({
    required this.average,
    required this.reviews,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    average: _toDouble(json["average"]),
    reviews: _toInt(json["reviews"]),
  );

  Map<String, dynamic> toJson() => {
    "average": average,
    "reviews": reviews,
  };
}

double _toDouble(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}
