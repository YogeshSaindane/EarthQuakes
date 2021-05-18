import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_demo/Model/Quake.dart';
import 'package:google_maps_demo/Network/Network.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class QuakesApp extends StatefulWidget {
  QuakesApp({Key key}) : super(key: key);

  @override
  _QuakesAppState createState() => _QuakesAppState();
}

class _QuakesAppState extends State<QuakesApp> {
//   18.6099378
// 73.8006991
  static final CameraPosition homeTownPosition =
      CameraPosition(target: LatLng(18.6099378, 73.8006991), zoom: 5);
  LatLng homeCoordinates = LatLng(18.6099378, 73.8006991);
  Future<Quake> quakeData;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markerList = <Marker>[];
  double _zoomVal = 5.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quakeData = Network().getAllQuakes();
    // quakeData.then(
    //     (value) => {print("places: ${value.features[0].properties.place}")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(context),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                zoomMinus(),
                zoomPlus(),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            findQuakes();
          },
          label: Text("Find Quake")),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: homeTownPosition,
        markers: Set<Marker>.of(_markerList),
      ),
    );
  }

  Widget zoomMinus() {
    return Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            _zoomVal--;
            _minus(_zoomVal);
          },
        ));
  }

  Widget zoomPlus() {
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
          color: Colors.red,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _zoomVal++;
              _minus(_zoomVal);
            },
          ),
        ));
  }

  void findQuakes() {
    setState(() {
      _markerList.clear();
      _handleResponse();
    });
  }

  void _handleResponse() {
    setState(() {
      quakeData.then((quakes) => {
            quakes.features.forEach((element) {
              Marker newMarker = Marker(
                  markerId: MarkerId(element.id),
                  infoWindow: InfoWindow(
                      snippet: "${element.properties.place}",
                      title: "${element.properties.mag}"),
                  position: LatLng(element.geometry.coordinates[1],
                      element.geometry.coordinates[0]),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen));
              _markerList.add(newMarker);
            })
          });
    });
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: homeCoordinates, zoom: zoomVal)));
  }
}
