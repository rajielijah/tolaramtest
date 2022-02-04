  import 'dart:ffi';

  import 'package:flutter/material.dart';
  import 'package:google_maps_flutter/google_maps_flutter.dart';
  import 'package:tolaramtest/map_model.dart';
import 'package:tolaramtest/marker_api.dart';


  class GoogleMapScreen extends StatefulWidget {
    const GoogleMapScreen({Key? key}) : super(key: key);
    
    @override
    _GoogleMapScreenState createState() => _GoogleMapScreenState();
  }

  class _GoogleMapScreenState extends State<GoogleMapScreen> {
    final Map<String, Marker> _markers = {};
    Future<void> _onMapCreated(GoogleMapController controller) async {
      final locations = await Locations.instances?.getLocations();
      final double long = double.parse("${locations!.lng}");
      final double lat = double.parse("${locations.lat}");
      setState(() {
        _markers.clear();
          final marker = Marker(
            markerId: MarkerId(locations.name),
            //lat and long coming from the endpoint is String and it's suppose to be double(decimal), that's why I can't put it here
            position: const LatLng(41.468233, 83.34522),
            // position: const LatLng(locations.lat, locations.lng as double),
            infoWindow: InfoWindow(
              title: locations.name,
              snippet: locations.name,
            ),
          );
          _markers[locations.name] = marker;
        }
      );
  } 
  late Future<LatLog> location;
  @override
    void initState(){
      super.initState();
      location = Locations.instances!.getLocations();
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
              zoom: 11,
            ),
            markers: _markers.values.toSet(),
          ),
          bottomSheet: GestureDetector(
              child: const Text("List of Location"),
              onTap: (){
                showModalBottomSheet<void>(context: context, builder: (context){
                  return FutureBuilder<LatLog>(
                    future: location,
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index){
                          return Column(
                            children: [
                              Text("${snapshot.data?.name}")
                            ],
                          );
                      });
                    }
                  );
                });
              },
            ),
          
        ),
      );
  
    }
  
  }