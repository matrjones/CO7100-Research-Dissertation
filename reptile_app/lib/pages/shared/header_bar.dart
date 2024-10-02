import 'package:flutter/material.dart';
import 'package:reptile_app/models/vivarium.dart';
import 'package:reptile_app/pages/my_homepage/my_homepage.dart';
import 'package:reptile_app/pages/vivarium_display/vivarium_display.dart';

// Definition of header bar
class HeaderBar extends StatefulWidget implements PreferredSizeWidget {
  const HeaderBar({super.key, required this.edit, this.vivarium});
  final Vivarium? vivarium;
  final bool edit;
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height + 1);
  @override
  State<HeaderBar> createState() => _HeaderBarState();
}

// Definition for functionality and appearance of vivarium cards
class _HeaderBarState extends State<HeaderBar> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(
        title: const Text(
          "Vivarium Tracker",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        leading: GestureDetector(
          onTap: moveToHome,
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(Icons.home),
          ),
        ),
        actions: <Widget>[
          Visibility(
            visible: widget.edit,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: moveToVivariumEdit,
                child: const Icon(Icons.edit),
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  // Home button method
  void moveToHome() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: "Homepage")
        )
    );
  }

  // Settings button method
  void moveToVivariumEdit() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VivariumDisplay(
            title: "Vivarium Edit",
            vivarium: widget.vivarium,
            detail: false,
          )
        )
    );
  }
}
