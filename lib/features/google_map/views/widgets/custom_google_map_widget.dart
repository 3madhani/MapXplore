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
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          circles: circles,
          polygons: polygons,
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

  void initCircles() {
    circles.add(
      const Circle(
        circleId: CircleId("1"),
        center: LatLng(29.971271978777594, 31.240305623789872),
        radius: 1000,
        strokeWidth: 5,
        strokeColor: Colors.green,
        fillColor: Colors.greenAccent,
      ),
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

  void initPolygon() {
    polygons.add(
      Polygon(
        holes: const [
          [
            LatLng(29.67327136304591, 30.778533209952737),
            LatLng(29.853637930520993, 30.4817103071314),
            LatLng(30.162080290939624, 30.689486339106328),
            LatLng(30.34156115704361, 30.778533209952737),
            LatLng(30.46956072947623, 31.134720693338334),
            LatLng(29.905111539509633, 31.69868420869886),
            LatLng(29.67327136304591, 30.778533209952737),
          ]
        ],
        fillColor: Colors.blueAccent.withOpacity(0.5),
        polygonId: const PolygonId("1"),
        points: const [
          LatLng(22.067677254382307, 25.012919363218035),
          LatLng(29.25078953150489, 25.012919363218035),
          LatLng(30.16135239762166, 24.648274335464787),
          LatLng(30.750718085884987, 25.012919363218035),
          LatLng(31.414329999787185, 24.785016220872258),
          LatLng(31.68623027506891, 25.195241877094652),
          LatLng(30.907278462675585, 32.624884317566995),
          LatLng(22.06767721086004, 36.86388296689067),
        ],
        strokeWidth: 5,
        strokeColor: Colors.green,
      ),
    );
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
    initCircles();
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
