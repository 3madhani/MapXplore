import 'package:flutter/material.dart';
import 'package:mapxplore/features/google_map/views/widgets/custom_google_map_widget.dart';

class GoogleMapView extends StatelessWidget {
  const GoogleMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomGoogleMapWidget(),
    );
  }
}
