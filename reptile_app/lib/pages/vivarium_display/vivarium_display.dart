import 'package:flutter/material.dart';
import 'package:reptile_app/pages/shared/header_bar.dart';
import 'package:reptile_app/pages/vivarium_display/widgets/vivarium_display_body.dart';

import '../../models/vivarium.dart';

class VivariumDisplay extends StatefulWidget {
  const VivariumDisplay(
      {super.key, required this.title, required this.vivarium, required this.detail});

  final String title;
  final Vivarium? vivarium;
  final bool detail;

  @override
  State<VivariumDisplay> createState() => _VivariumDisplayState();
}

class _VivariumDisplayState extends State<VivariumDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        edit: widget.detail,
        vivarium: widget.vivarium,
      ),
      body: VivariumDisplayBody(
        vivarium: widget.vivarium,
        detail: widget.detail,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
