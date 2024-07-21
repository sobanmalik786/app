import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CallMapWithMarker extends StatelessWidget {
  final double lat;
  final double long;
  final String SuperiorUnvirestyGlodCampus;

  const CallMapWithMarker(
      {super.key,
      required this.lat,
      required this.SuperiorUnvirestyGlodCampus,
      required this.long});

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> controller = Completer();
    List<Marker> marker = [
      Marker(
          markerId: const MarkerId('1'),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(title: SuperiorUnvirestyGlodCampus)),
    ];

    return GoogleMap(
      markers: Set<Marker>.of(marker),
      initialCameraPosition: CameraPosition(
        target: LatLng(lat, long),
        zoom: 14.4746,
      ),
      onMapCreated: (mapController) {
        controller.complete(mapController);
      },
    );
  }
}
