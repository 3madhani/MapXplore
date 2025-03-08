import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/place_model.dart';

class CustomGoogleMapWidget extends StatefulWidget {
  const CustomGoogleMapWidget({super.key});

  @override
  State<CustomGoogleMapWidget> createState() => _CustomGoogleMapWidgetState();
}

class _CustomGoogleMapWidgetState extends State<CustomGoogleMapWidget> {
  late CameraPosition _initialCameraPosition;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
          },
          initialCameraPosition: _initialCameraPosition,
          markers: markers,
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     southwest: const LatLng(30.054053675424868, 31.22491658611096),
          //     northeast: const LatLng(30.054053675424868, 31.22491658611096),
          //   ),
          // ),
        ),
        // Positioned(
        //     right: 16,
        //     left: 16,
        //     bottom: 16,
        //     child: ElevatedButton(
        //         onPressed: () {
        //           // change location
        //           googleMapController.animateCamera(
        //             CameraUpdate.newCameraPosition(
        //               const CameraPosition(
        //                 target: LatLng(31.200515535160406, 29.93842333340524),
        //                 zoom: 12,
        //               ),
        //             ),
        //           );
        //         },
        // child: const Text(
        //   "Change Location",
        //   style: TextStyle(
        //     fontSize: 20,
        //   ),
        // ),
        // ),)
      ],
    );
  }

  void initMapStyle() async {
    String nightStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');
    googleMapController.setMapStyle(nightStyle);
  }

  void initMarker() async {
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/icons/location-point.png');
    for (var place in places) {
      markers.add(Marker(
        icon: customIcon,
        markerId: MarkerId(place.id.toString()),
        position: place.location,
        infoWindow: InfoWindow(
          title: place.name,
        ),
      ));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initMarker();
    _initialCameraPosition = const CameraPosition(
      target: LatLng(30.054053675424868, 31.22491658611096),
      zoom: 6,
    );
  }
}

// world view of the map 0 -> 3
// country view of the map 4 -> 7
// city view of the map 8 -> 12
// street view of the map 13 -> 17
// building view of the map 18 -> 22
