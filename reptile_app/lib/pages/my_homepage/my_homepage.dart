import 'package:flutter/material.dart';
import 'package:reptile_app/pages/my_homepage/widgets/homepage_body.dart';
import 'package:reptile_app/pages/shared/header_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HeaderBar(edit: false,),
      body:
          HomepageBody(),
    );
  }
}
