import 'package:flutter/material.dart';
import 'package:mapxplore/features/google_map/views/google_map_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GoogleMapView(),
    );
  }
}
