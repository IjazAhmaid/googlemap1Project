import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineScreen extends StatefulWidget {
  const PolyLineScreen({
    super.key,
  });

  @override
  State<PolyLineScreen> createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14.4746,
  );

  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = {};
  List<LatLng> latlong = [
    const LatLng(33.6844, 73.0479),
    const LatLng(31.5204, 74.3587),
    const LatLng(33.6844, 73.0479),
    const LatLng(24.8607, 67.0011),
  ];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < latlong.length; i++) {
      _marker.add(Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId(i.toString()),
        position: latlong[i],
        infoWindow: const InfoWindow(
            snippet: 'Ijaz Ahmad developer', title: "Good places"),
      ));

      setState(() {});
      _polyline.add(Polyline(
          polylineId: const PolylineId('1'),
          points: latlong,
          color: Colors.orangeAccent));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PolyLine Screen'),
      ),
      body: GoogleMap(
        markers: _marker,
        polylines: _polyline,
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
