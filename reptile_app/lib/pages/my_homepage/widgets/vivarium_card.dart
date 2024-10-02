import 'package:flutter/material.dart';
import 'package:reptile_app/models/vivarium.dart';

// Vivarium card definition
class VivariumCard extends StatelessWidget {
  const VivariumCard({super.key, required this.vivarium});
  final Vivarium vivarium;

  // Convert times to number of minutes since midnight to calculate if light's on or off
  bool compareTimeOfDay(TimeOfDay t1, TimeOfDay t2) {
    return t1.hour * 60 + t1.minute > t2.hour * 60 + t2.minute;
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay now = TimeOfDay.now();

    // Calculate if its daytime (lights on) or nighttime (lights off)
    bool isDayTime = compareTimeOfDay(now, vivarium.parameter.lightOn) &&
        compareTimeOfDay(vivarium.parameter.lightOff, now);

    // Daytime =  use day temp, nighttime = use night temp
    int targetTemperature = isDayTime
        ? vivarium.parameter.dayTemp
        : vivarium.parameter.nightTemp;

    // If temperature is as set it is green, otherwise it's red
    bool isTempTooHigh = vivarium.environment.temperature.round() > targetTemperature;
    bool isTempTooLow = vivarium.environment.temperature.round() < targetTemperature;
    Color tempColor = (isTempTooHigh || isTempTooLow) ? Colors.red : Colors.green;

    // Definition for functionality and appearance of vivarium cards
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                vivarium.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10.0)),
                child: Image.asset(
                  vivarium.environment.light
                      ? 'assets/images/light_bulb_on.png'
                      : 'assets/images/light_bulb_off.png',
                  width: 60,
                  height: 60,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text(vivarium.environment.light ? 'ON' : 'OFF',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      )))
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4.0),
                Center(
                  child: Text(
                    '${vivarium.environment.temperature.round()}°C',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: tempColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
