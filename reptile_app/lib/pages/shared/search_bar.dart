import 'package:flutter/material.dart';

// Definition of search bar functionality
class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key, required this.controller, required this.text});
  final TextEditingController controller;
  final String text;

  // Build for search bar
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
