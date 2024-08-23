import 'package:flutter/material.dart';
import 'package:reptile_app/pages/my_homepage/my_homepage.dart';

class HeaderBar extends StatefulWidget implements PreferredSizeWidget {
  const HeaderBar({super.key});

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

        // SETTINGS BUTTON
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: moveToSettings,
              child: const Icon(Icons.menu),
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
            builder: (context) => const MyHomePage(title: "Homepage")));
  }

  // SETTINGS BUTTON METHOD
  void moveToSettings() {}
}
