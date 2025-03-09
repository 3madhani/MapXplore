// import 'dart:typed_data';
// import 'dart:ui' as ui;

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
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
  Set<Polyline> polylines = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          polylines: polylines,
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

  void initPolyLine() {
    polylines.add(
      const Polyline(
        patterns: [
          PatternItem.dot,
        ],
        zIndex: 2,
        polylineId: PolylineId("1"),
        points: [
          LatLng(29.884473250794628, 31.289413699652787),
          LatLng(29.897941987122827, 31.294649371484375),
          LatLng(29.90333744766924, 31.294647812359262),
          LatLng(29.93058925303125, 31.281068968301764),
        ],
        startCap: Cap.roundCap,
        color: Colors.green,
        width: 5,
      ),
    );
    polylines.add(
      const Polyline(
        zIndex: 1,
        polylineId: PolylineId("2"),
        points: [
          LatLng(29.905813642734255, 31.268901323824384),
          LatLng(29.90465227787391, 31.293184311976674),
          LatLng(29.898845250269872, 31.305577010744162),
          LatLng(29.871547688880366, 31.316295019307933),
        ],
        startCap: Cap.roundCap,
        color: Colors.red,
        width: 5,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initMarker();
    initPolyLine();
    _initialCameraPosition = const CameraPosition(
      target: LatLng(30.054053675424868, 31.22491658611096),
      zoom: 12,
    );
  }

  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
  //       !.buffer
  //       .asUint8List();
  // }
}

// world view of the map 0 -> 3
// country view of the map 4 -> 7
// city view of the map 8 -> 12
// street view of the map 13 -> 17
// building view of the map 18 -> 22
