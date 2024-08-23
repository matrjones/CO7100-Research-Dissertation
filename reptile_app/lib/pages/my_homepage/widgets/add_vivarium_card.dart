import 'package:flutter/material.dart';

class AddVivariumCard extends StatelessWidget {
  const AddVivariumCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 110),
                      textAlign: TextAlign.center,
                    )))
          ],
        ));
  }
}
