import 'dart:io';

class PlaceLocation {
  final String latitude;
  final String longitude;
  final String address;

  PlaceLocation(
      {required this.latitude, required this.longitude, required this.address});
}

class GreatPlaceModel {
  final String id;
  final String title;
  final File imageUrl;
  final String location;

  GreatPlaceModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.location});
}
