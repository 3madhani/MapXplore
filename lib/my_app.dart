import 'package:flutter/material.dart';
import 'package:mapxplore/google_map/google_map_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GoogleMapView(),
    );
  }
}
