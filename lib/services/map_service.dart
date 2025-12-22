import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  static LatLng toLatLng(Map<String, dynamic> data) {
    return LatLng(data['latitude'], data['longitude']);
  }
}
