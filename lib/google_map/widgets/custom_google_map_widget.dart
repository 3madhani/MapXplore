import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMapWidget extends StatefulWidget {
  const CustomGoogleMapWidget({super.key});

  @override
  State<CustomGoogleMapWidget> createState() => _CustomGoogleMapWidgetState();
}

class _CustomGoogleMapWidgetState extends State<CustomGoogleMapWidget> {
  late CameraPosition _initialCameraPosition;
  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) => googleMapController = controller,
          initialCameraPosition: _initialCameraPosition,
          mapType: MapType.normal,
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     southwest: const LatLng(30.054053675424868, 31.22491658611096),
          //     northeast: const LatLng(30.054053675424868, 31.22491658611096),
          //   ),
          // ),
        ),
        Positioned(
            right: 16,
            left: 16,
            bottom: 16,
            child: ElevatedButton(
                onPressed: () {
                  // change location
                  googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      const CameraPosition(
                        target: LatLng(31.200515535160406, 29.93842333340524),
                        zoom: 12,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Change Location",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = const CameraPosition(
      target: LatLng(30.054053675424868, 31.22491658611096),
      zoom: 12,
    );
  }
}

// world view of the map 0 -> 3
// country view of the map 4 -> 7
// city view of the map 8 -> 12
// street view of the map 13 -> 17
// building view of the map 18 -> 22
