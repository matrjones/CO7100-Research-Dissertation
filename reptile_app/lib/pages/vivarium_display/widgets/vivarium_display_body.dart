/*
TODO
  -  implement green/red temperature display
*/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reptile_app/models/environment.dart';
import 'package:reptile_app/pages/my_homepage/my_homepage.dart';
import 'package:reptile_app/pages/vivarium_display/vivarium_display.dart';
import 'package:reptile_app/models/parameter.dart';
import 'package:reptile_app/models/vivarium.dart';
import 'package:http/http.dart' as http;

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
                        labelText: widget.vivarium == null ? "" : widget.vivarium!.name,
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
                                      initialTime: const TimeOfDay(hour: 00, minute: 00),
                                      builder: (BuildContext context, Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );
                                  if (timeOfDay != null) {
                                    setState(() {
                                      lightOnController.text = timeOfDay
                                        .toString()
                                        .substring(10, 15);
                                    });
                                  }
                                },
                                controller: lightOnController,
                                decoration: InputDecoration(
                                  labelText:
                                    widget.vivarium == null ? "00:00" :
                                    widget.vivarium!.parameter.lightOn
                                        .toString()
                                        .substring(10, 15),
                                  border: const OutlineInputBorder(),
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
                                      initialTime: const TimeOfDay(hour: 00, minute: 00),
                                      builder: (BuildContext context, Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );
                                  if (timeOfDay != null) {
                                    setState(() {
                                      lightOffController.text = timeOfDay
                                        .toString()
                                        .substring(10, 15);
                                    });
                                  }
                                },
                                controller: lightOffController,
                                decoration: InputDecoration(
                                  labelText:
                                    widget.vivarium == null ? "00:00" :
                                    widget.vivarium!.parameter.lightOff
                                      .toString()
                                      .substring(10, 15),
                                  border: const OutlineInputBorder(),
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
                                decoration: InputDecoration(
                                  labelText: widget.vivarium == null ? "0" : widget.vivarium!.parameter.dayTemp.toString(),
                                  border: const OutlineInputBorder(),
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
                                decoration: InputDecoration(
                                  labelText: widget.vivarium == null ? "0" :widget.vivarium!.parameter.nightTemp.toString(),
                                  border: const OutlineInputBorder(),
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
                    Visibility(
                      visible: widget.vivarium == null ? false : true,
                      child: Padding(
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveButtonPressed() async {
    if (widget.vivarium == null) {
      var response = await addVivarium();
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
    }
    else {
      var response = await updateVivarium();
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
    }
    navigateHome();
  }

  void cancelButtonPressed() {
    if(widget.vivarium == null){
      navigateHome();
    }else{
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
      onPressed: () async {
        var response = await deleteVivarium();
        if (response.statusCode != 200) {
          throw Exception(response.body);
        }
        navigateHome();
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

  // HTTP request for creating new vivarium
  Future<http.Response> addVivarium() async {
    return http.post(
      Uri.parse('http://192.168.1.153:8080/api/Vivarium/Create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        Vivarium(
          name: vivNameController.text,
          environment: Environment(temperature: 0, light: false),
          parameter: Parameter(
            lightOn: TimeOfDay(
              hour: int.parse(lightOnController.text.substring(0, 2)),
              minute: int.parse(lightOnController.text.substring(3, 5)),
            ),
            lightOff: TimeOfDay(
              hour: int.parse(lightOffController.text.substring(0, 2)),
              minute: int.parse(lightOffController.text.substring(3, 5)),
            ),
            dayTemp: int.parse(dayTempController.text),
            nightTemp: int.parse(nightTempController.text),
          )
        ).toJson()
      )
    );
  }

  // HTTP request for updating existing vivarium
  Future<http.Response> updateVivarium() async {
    if (vivNameController.text != "") {
      widget.vivarium!.name = vivNameController.text;
    }

    if (lightOnController.text != "") {
      widget.vivarium!.parameter.lightOn = TimeOfDay(
        hour: int.parse(lightOnController.text.substring(0, 2)),
        minute: int.parse(lightOnController.text.substring(3, 5)),
      );
    }

    if (lightOffController.text != "") {
      widget.vivarium!.parameter.lightOff = TimeOfDay(
        hour: int.parse(lightOffController.text.substring(0, 2)),
        minute: int.parse(lightOffController.text.substring(3, 5)),
      );
    }

    if (dayTempController.text != "") {
      widget.vivarium!.parameter.dayTemp = int.parse(dayTempController.text);
    }

    if (nightTempController.text != "") {
      widget.vivarium!.parameter.nightTemp = int.parse(nightTempController.text);
    }

    return http.post(
        Uri.parse('http://192.168.1.153:8080/api/Vivarium/Update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(widget.vivarium!.toJson()),
    );
  }

  // HTTP request for deleting a vivarium
  Future<http.Response> deleteVivarium() async {
    return http.delete(
      Uri.parse('http://192.168.1.153:8080/api/Vivarium/DeleteById?id=${widget.vivarium!.id}'),
    );
  }

  void navigateHome(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "Homepage")
        )
    );
  }
}
