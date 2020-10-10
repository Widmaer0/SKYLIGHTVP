import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';

class TurfProvider extends ChangeNotifier {
  bool _gettingCurrentLocation;
  LatLng _currentLocation;
  String _mapStyleString;

  getCurrentLocation() async {
    _gettingCurrentLocation = true;
    notifyListeners();
    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;
    var currentLocation = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Location detected : $currentLocation");
    _gettingCurrentLocation = false;
    _currentLocation =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    notifyListeners();
  }


  setMapStyleString(String value)
  {
    _mapStyleString=value;

    notifyListeners();
  }


  LatLng get currentLocation => _currentLocation;

  bool get gettingCurrentLocation => _gettingCurrentLocation;

  String get getMapStyleString => _mapStyleString;


}
