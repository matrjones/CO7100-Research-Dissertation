import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key, required this.controller, required this.text});

  final TextEditingController controller;
  final String text;

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
