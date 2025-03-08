import 'package:google_maps_flutter/google_maps_flutter.dart';

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'Cairo',
    location: const LatLng(29.969268255191015, 31.24135989566431),
  ),
  PlaceModel(
    id: 2,
    name: 'Alexandria',
    location: const LatLng(31.200515535160406, 29.93842333340524),
  ),
  PlaceModel(
    id: 3,
    name: 'Aswan',
    location: const LatLng(24.088938, 32.899829),
  ),
  PlaceModel(
    id: 4,
    name: 'Luxor',
    location: const LatLng(25.687243, 32.639637),
  ),
];

class PlaceModel {
  final int id;
  final String name;
  final LatLng location;

  PlaceModel({
    required this.id,
    required this.name,
    required this.location,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      name: json['name'],
      location: LatLng(
        json['latitude'],
        json['longitude'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': location.latitude,
      'longitude': location.longitude,
    };
  }
}
