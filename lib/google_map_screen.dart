import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tolaramtest/map_model.dart';
// import 'src/locations.dart' as locations;


class MyApps extends StatefulWidget {
  const MyApps({Key? key}) : super(key: key);

  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final locations = await Locations.instances?.getLocations();
    setState(() {
      _markers.clear();
        final marker = Marker(
          markerId: MarkerId(locations!.name),
          //lat and long coming from the endpoint is String and it's suppose to be double(decimal), that's why I can't put it here
          position: const LatLng(3, 4),
          infoWindow: InfoWindow(
            title: locations.name,
            snippet: locations.name,
          ),
        );
        _markers[locations.name] = marker;
      }
    );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Locations'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(45.521563, -122.677433),
            zoom: 2,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}