import 'package:flutter/material.dart';
import 'package:mapxplore/google_map/widgets/custom_google_map_widget.dart';

class GoogleMapView extends StatelessWidget {
  const GoogleMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomGoogleMapWidget(),
    );
  }
}
