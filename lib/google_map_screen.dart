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
          position: const LatLng(3,4),
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
          title: const Text('Google Office Locations'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 2,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}