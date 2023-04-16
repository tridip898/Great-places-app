import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  String? lati;
  String? longi;

  Future<Position> _getlocation() async {
    bool _serviceEnabled;
    LocationPermission permission;
    //check the location service is enabled or not
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      return Future.error('Locator service are not enabled');
    }

    //check the permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permission denied permanently, we can\'t request');
    }
    return await Geolocator.getCurrentPosition();
  }

  //listen to location updates
  void _liveLocation() {
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lati = position.latitude.toString();
      longi = position.longitude.toString();
    });
  }

  Future<void> _openMap(String lati, String longi) async{
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lati,$longi';
    await canLaunchUrlString(googleUrl)
        ? await launchUrlString(googleUrl)
        : throw 'Could not launch $googleUrl';
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade600),
            borderRadius: BorderRadius.circular(10)
          ),
          child: _previewImageUrl == null
              ? const Text(
                  "No location chosen",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: ()=>_getlocation().then((value) {
                  lati="${value.latitude}";
                  longi="${value.longitude}";
                  _liveLocation();
                }),
                icon: const Icon(Icons.location_on),
                label: Text(
                  "Current Location",
                  style: TextStyle(color: Colors.grey.shade500),
                )),
            TextButton.icon(
                onPressed:()=> _openMap(lati!,longi!),
                icon: const Icon(Icons.map),
                label: Text(
                  "Select on Map",
                  style: TextStyle(color: Colors.grey.shade500),
                ))
          ],
        )
      ],
    );
  }
}
