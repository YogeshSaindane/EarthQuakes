import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatefulWidget {
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  GoogleMapController mapController;
  final LatLng _center = const LatLng(18.5204, 73.8567);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home town"),
      ),
      body: GoogleMap(
        markers: {placeMarker},
        mapType: MapType.hybrid,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center, zoom: 12),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToLocation,
        label: Text("HomeTown"),
        icon: Icon(Icons.home),
      ),
    );
  }

  Marker placeMarker = Marker(
      markerId: MarkerId("Pune"),
      position: LatLng(18.5204, 73.8567),
      infoWindow: InfoWindow(title: "Pune City", snippet: "Here is city"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
  static final CameraPosition homeTownPosition = CameraPosition(
      target: LatLng(20.988365844473467, 75.34123183846658), zoom: 5);
  Future<void> _goToLocation() async {
    final GoogleMapController controller = await mapController;

    controller.animateCamera(CameraUpdate.newCameraPosition(homeTownPosition));
  }
}
