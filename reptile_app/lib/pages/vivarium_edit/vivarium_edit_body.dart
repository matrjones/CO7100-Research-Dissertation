import 'package:flutter/material.dart';

class VivariumDisplayBody extends StatefulWidget
    implements PreferredSizeWidget {
  const VivariumDisplayBody({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height + 1);

  @override
  State<VivariumDisplayBody> createState() => _VivariumDisplayBodyState();
}

class _VivariumDisplayBodyState extends State<VivariumDisplayBody> {
  final vivNameController = TextEditingController();
  final lightOnController = TextEditingController();
  final lightOffController = TextEditingController();

  @override
  void dispose() {
    vivNameController.dispose();
    lightOnController.dispose();
    lightOffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // VIVARIUM NAME
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
                        decoration: const InputDecoration(
                          labelText: 'Vivarium Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ])),

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
                              ])),
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
                              ])),
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
                              ])),
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
                              ])),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
