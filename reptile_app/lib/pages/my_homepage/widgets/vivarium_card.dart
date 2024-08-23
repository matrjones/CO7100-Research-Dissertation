import 'package:flutter/material.dart';
import 'package:reptile_app/models/vivarium.dart';

class VivariumCard extends StatelessWidget {
  const VivariumCard({super.key, required this.vivarium});

  final Vivarium vivarium;

  @override
  Widget build(BuildContext context) {
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
                  vivarium.lighting
                      ? 'assets/images/light_bulb_on.png'
                      : 'assets/images/light_bulb_off.png',
                  width: 60,
                  height: 60,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text(vivarium.lighting ? 'ON' : 'OFF',
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
                    '${vivarium.temperature}°C',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color:
                          vivarium.temperature > 30 ? Colors.red : Colors.green,
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
