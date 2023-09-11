import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyGoneScreen extends StatefulWidget {
  const PolyGoneScreen({super.key});

  @override
  State<PolyGoneScreen> createState() => _PolyGoneScreenState();
}

class _PolyGoneScreenState extends State<PolyGoneScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14.4746,
  );
  // final Set<Polygon> _markers = {};
  final Set<Polygon> _polygon = HashSet<Polygon>();
  List<LatLng> points = [
    const LatLng(33.6844, 73.0479),
    const LatLng(31.5204, 74.3587),
    const LatLng(24.8607, 67.0011),
    const LatLng(33.6844, 73.0479)
  ];

  @override
  void initState() {
    super.initState();
    _polygon.add(Polygon(
        polygonId: const PolygonId('1'),
        points: points,
        fillColor: Colors.redAccent.withOpacity(.3),
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.deepOrange));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PolyGon on Google Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        polygons: _polygon,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
