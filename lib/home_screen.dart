import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController ijazcontroller = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14.4746,
  );
  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        infoWindow: InfoWindow(title: "Islamabad"),
        markerId: MarkerId('1'),
        position: LatLng(33.6844, 73.0479)),
    Marker(
        infoWindow: InfoWindow(title: "Lahore"),
        markerId: MarkerId('2'),
        position: LatLng(31.5204, 74.3587)),
    Marker(
        infoWindow: InfoWindow(title: "Karachi"),
        markerId: MarkerId('3'),
        position: LatLng(24.8607, 67.0011)),
    Marker(
        infoWindow: InfoWindow(title: "Layyah"),
        markerId: MarkerId('3'),
        position: LatLng(30.9693, 70.9428)),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(fillColor: Colors.amber),
          controller: ijazcontroller,
        ),
      ),
      body: Stack(children: [
        SafeArea(
          child: GoogleMap(
            markers: Set<Marker>.of(_marker),
            myLocationEnabled: true,
            compassEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ]),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          child: const Icon(Icons.location_disabled_outlined),
          onPressed: () async {
            List<Location> locations =
                await locationFromAddress(ijazcontroller.text.toString());
            double lat1 = locations.reversed.last.latitude.toDouble();
            double long2 = locations.reversed.last.longitude.toDouble();
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(lat1, long2), zoom: 14)));

            setState(() {});
          },
        ),
      ),
    );
  }
}
