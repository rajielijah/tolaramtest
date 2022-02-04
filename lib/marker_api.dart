import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tolaramtest/map_model.dart';

//Calling the endpoint.

class Locations{
  static Locations? _instances;
  Locations._();
  static Locations? get instances {
    _instances ??= Locations._();
    return _instances;
  }
Future<LatLog> getLocations() async {
  const LatLogURL = 'https://enpuyr7bafpswlw.m.pipedream.net/';
   final response = await http.get(Uri.parse(LatLogURL));
  // Retrieve the LatLog from the endpoint Provided
  try {
    final response = await http.get(Uri.parse(LatLogURL));
    if (response.statusCode == 200) {
      return LatLog.fromJson(json.decode(response.body));
    }
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }

  // Fallback for when the above HTTP request fails.
  return LatLog.fromJson(json.decode('${response.statusCode}'));
}}