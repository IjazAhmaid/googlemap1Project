import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocationScreen extends StatefulWidget {
  const GetUserCurrentLocationScreen({super.key});

  @override
  State<GetUserCurrentLocationScreen> createState() =>
      _GetUserCurrentLocationScreenState();
}

class _GetUserCurrentLocationScreenState
    extends State<GetUserCurrentLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14.4746,
  );

  final List<Marker> _marker = <Marker>[
    const Marker(
        infoWindow: InfoWindow(title: "Islamabad"),
        markerId: MarkerId('1'),
        position: LatLng(33.6844, 73.0479)),
  ];
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  loadData() {
    getUserCurrentLocation().then((value) async {
      print("My Current Location");
      print("${value.latitude}${value.longitude}");
      _marker.add(
        Marker(
            infoWindow: const InfoWindow(title: "Your Current Position"),
            markerId: const MarkerId('1'),
            position: LatLng(value.latitude, value.longitude)),
      );
      CameraPosition cameraPosition =
          CameraPosition(target: LatLng(value.latitude, value.longitude));
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  /* @override
  void initState() {
    super.initState();
    loadData;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.local_activity),
        onPressed: () {
          getUserCurrentLocation().then((value) async {
            print("My Current Location");
            print("${value.latitude}${value.longitude}");
            _marker.add(
              Marker(
                  infoWindow: const InfoWindow(title: "Your Current Position"),
                  markerId: const MarkerId('1'),
                  position: LatLng(value.latitude, value.longitude)),
            );
            CameraPosition cameraPosition =
                CameraPosition(target: LatLng(value.latitude, value.longitude));
            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
      ),
    );
  }
}
