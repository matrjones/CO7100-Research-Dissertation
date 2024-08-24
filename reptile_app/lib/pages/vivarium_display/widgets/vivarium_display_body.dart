/*
TODO
  -  implement delete functionality
  -  implement save functionality
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reptile_app/pages/vivarium_display/vivarium_display.dart';
import '../../../models/vivarium.dart';

class VivariumDisplayBody extends StatefulWidget
    implements PreferredSizeWidget {
  const VivariumDisplayBody({super.key, required this.vivarium, required this.detail});

  final Vivarium? vivarium;
  final bool detail;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height + 1);

  @override
  State<VivariumDisplayBody> createState() => _VivariumDisplayBodyState();
}

class _VivariumDisplayBodyState extends State<VivariumDisplayBody> {
  final vivNameController = TextEditingController();
  final lightOnController = TextEditingController();
  final lightOffController = TextEditingController();
  final dayTempController = TextEditingController();
  final nightTempController = TextEditingController();

  @override
  void dispose() {
    vivNameController.dispose();
    lightOnController.dispose();
    lightOffController.dispose();
    dayTempController.dispose();
    nightTempController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // VIVARIUM NAME
        child: IgnorePointer(
        ignoring: widget.detail,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Vivarium Name:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                      textAlign: TextAlign.left,
                    ),
                    TextField(
                      controller: vivNameController,
                      decoration: InputDecoration(
                        labelText: widget.vivarium?.name,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ]
                )
              ),

              // LIGHTING
              Row(
                children: [
                  // LIGHT ON
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Light On:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                                textAlign: TextAlign.left,
                              ),
                              TextField(
                                onTap: () async {
                                  final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                      context: context,
                                      initialTime: const TimeOfDay(
                                        hour: 0, minute: 0));
                                  if (timeOfDay != null) {
                                    setState(() {
                                      lightOnController.text = timeOfDay
                                        .toString()
                                        .substring(10, 15);
                                    });
                                  }
                                },
                                controller: lightOnController,
                                decoration: const InputDecoration(
                                  labelText: '00:00',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  // LIGHT OFF
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Light Off:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                                textAlign: TextAlign.left,
                              ),
                              TextField(
                                onTap: () async {
                                  final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                      context: context,
                                      initialTime: const TimeOfDay(
                                        hour: 0, minute: 0));
                                  if (timeOfDay != null) {
                                    setState(() {
                                      lightOffController.text = timeOfDay
                                        .toString()
                                        .substring(10, 15);
                                    });
                                  }
                                },
                                controller: lightOffController,
                                decoration: const InputDecoration(
                                  labelText: '00:00',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // DAYTIME TEMPERATURE
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Day Temperature:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                                textAlign: TextAlign.left,
                              ),
                              TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                controller: dayTempController,
                                decoration: const InputDecoration(
                                  labelText: '0',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Nighttime TEMPERATURE
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Night Temperature:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                                textAlign: TextAlign.left,
                              ),
                              TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                controller: nightTempController,
                                decoration: const InputDecoration(
                                  labelText: '0',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // DETAIL BUTTONS
              Visibility(
                visible: !widget.detail,
                child: Column(
                  children: [

                    // SAVE BUTTON
                    Padding(
                      padding: const EdgeInsets.fromLTRB(64, 32, 64, 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: saveButtonPressed,
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                                backgroundColor: WidgetStateProperty.all<Color>(Colors.indigo),
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                  const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                              ),
                              child: const Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // CANCEL BUTTON
                    Padding(
                      padding: const EdgeInsets.fromLTRB(64, 0, 64, 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: cancelButtonPressed,
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                                backgroundColor: WidgetStateProperty.all<Color>(Colors.white38),
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                  const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                              ),
                              child: const Text('Cancel'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // DELETE BUTTON
                    Padding(
                      padding: const EdgeInsets.fromLTRB(64, 0, 64, 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {deleteButtonPressed(context);},
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                                backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                  const TextStyle(fontSize: 32, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                                ),
                              ),
                              child: const Text('Delete'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveButtonPressed() {

  }

  void cancelButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VivariumDisplay(
          title: "Vivarium Display",
          vivarium: widget.vivarium,
          detail: true,
        )
      )
    );
  }

  // DELETE ALERT
  void deleteButtonPressed(BuildContext context) {
    Widget noButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Warning!"),
      content: const Text("Are you sure you want to delete this vivarium?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
