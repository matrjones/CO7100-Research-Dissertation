import 'package:flutter/material.dart';
import 'package:reptile_app/pages/shared/header_bar.dart';
import 'package:reptile_app/pages/vivarium_display/widgets/vivarium_display_body.dart';

import '../../models/vivarium.dart';

class VivariumDisplay extends StatefulWidget {
  const VivariumDisplay(
      {super.key, required this.title, required this.vivarium});

  final String title;
  final Vivarium vivarium;

  @override
  State<VivariumDisplay> createState() => _VivariumDisplayState();
}

class _VivariumDisplayState extends State<VivariumDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBar(),
      body: VivariumDisplayBody(
          vivarium: widget
              .vivarium), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
