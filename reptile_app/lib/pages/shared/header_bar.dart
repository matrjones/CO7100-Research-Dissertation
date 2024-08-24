import 'package:flutter/material.dart';
import 'package:reptile_app/models/vivarium.dart';
import 'package:reptile_app/pages/my_homepage/my_homepage.dart';
import 'package:reptile_app/pages/vivarium_display/vivarium_display.dart';

class HeaderBar extends StatefulWidget implements PreferredSizeWidget {
  const HeaderBar({super.key, required this.edit, this.vivarium});

  final Vivarium? vivarium;
  final bool edit;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height + 1);

  @override
  State<HeaderBar> createState() => _HeaderBarState();
}

class _HeaderBarState extends State<HeaderBar> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(
        // APP  TITLE
        title: const Text(
          "Vivarium Tracker",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,

        // HOME BUTTON
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

  // HOME BUTTON METHOD
  void moveToHome() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: "Homepage")
        )
    );
  }

  // SETTINGS BUTTON METHOD
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
