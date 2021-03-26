import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 200,
        height: 200,
        child: Image.network('https://picsum.photos/250?image=9')

      ),
    );
  }
}
