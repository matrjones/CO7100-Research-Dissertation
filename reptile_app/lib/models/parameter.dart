import 'package:flutter/material.dart';

class Parameter {
  final String? id;
  TimeOfDay lightOn;
  TimeOfDay lightOff;
  int dayTemp;
  int nightTemp;
  final DateTime? createdDate;
  final DateTime? modifiedDate;

  Parameter({
    this.id,
    required this.lightOn,
    required this.lightOff,
    required this.dayTemp,
    required this.nightTemp,
    this.createdDate,
    this.modifiedDate,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    try {
      return Parameter(
        lightOn: TimeOfDay(
            hour: int.parse(json['LightOn']!.substring(0, 2)),
            minute: int.parse(json['LightOn']!.substring(3, 5))),
        lightOff: TimeOfDay(
            hour: int.parse(json['LightOff']!.substring(0, 2)),
            minute: int.parse(json['LightOff']!.substring(3, 5))),
        dayTemp: json['DayTemp'] as int,
        nightTemp: json['NightTemp'] as int,
        id: json['Id'] as String,
        createdDate: DateTime.parse(json['CreatedDate'] as String),
        modifiedDate: DateTime.parse(json['ModifiedDate'] as String),
      );
    } catch (e) {
      throw FormatException('Invalid JSON structure: $e');
    }
  }

  Map<String, dynamic> toJson() {
    var json = {
      'LightOn': "${lightOn.toString().substring(10,15)}:00",
      'LightOff': "${lightOff.toString().substring(10,15)}:00",
      'DayTemp': dayTemp,
      'NightTemp': nightTemp,
    };

    if(id != null){
      json['Id'] = id!;
    }
    return json;
  }
}
