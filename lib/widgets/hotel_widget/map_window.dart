import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWindow extends StatelessWidget {
  final List<LatLng> hotelLocations;
  final List<LatLng> attractionLocations;
  final LatLng? userLocation;

  const MapWindow({
    required this.hotelLocations,
    required this.attractionLocations,
    this.userLocation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = {
      ...hotelLocations.map((loc) => Marker(
            markerId: MarkerId('hotel_${loc.latitude}_${loc.longitude}'),
            position: loc,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            infoWindow: const InfoWindow(title: "Hotel"),
          )),
      ...attractionLocations.map((loc) => Marker(
            markerId: MarkerId('attraction_${loc.latitude}_${loc.longitude}'),
            position: loc,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
            infoWindow: const InfoWindow(title: "Attraction"),
          )),
      if (userLocation != null)
        Marker(
          markerId: const MarkerId('user'),
          position: userLocation!,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(title: "You"),
        ),
    };

    return Scaffold(
      appBar: AppBar(title: const Text("Map View")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: userLocation ?? hotelLocations.first,
          zoom: 12,
        ),
        markers: markers,
        myLocationEnabled: userLocation != null,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
