import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


List<LatLog> latLogFromJson(String str) => List<LatLog>.from(json.decode(str).map((x) => LatLog.fromJson(x)));

String latLogToJson(List<LatLog> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class LatLog {
    LatLog({
        required this.lat,
        required this.lng,
        required this.name,
        required this.active,
    });

    String lat;
    String lng;
    String name;
    bool active;

    factory LatLog.fromJson(Map<String, dynamic> json) => LatLog(
        lat: json["lat"],
        lng: json["lng"],
        name: json["name"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "name": name,
        "active": active,
    };

}

