import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class CustomMarkerWithNetworkImage extends StatefulWidget {
  const CustomMarkerWithNetworkImage({super.key});

  @override
  State<CustomMarkerWithNetworkImage> createState() =>
      _CustomMarkerWithNetworkImageState();
}

class _CustomMarkerWithNetworkImageState
    extends State<CustomMarkerWithNetworkImage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14.4746,
  );
  final List<Marker> _marker = [];
  final List<LatLng> _latlong = [
    const LatLng(33.6844, 73.0479),
    const LatLng(31.5204, 74.3587),
    const LatLng(33.6844, 73.0479),
    const LatLng(24.8607, 67.0011),
  ];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < _latlong.length; i++) {
      Uint8List? image = await loadNetworkImage(
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif');
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
          image!.buffer.asUint8List(),
          targetHeight: 50,
          targetWidth: 50);
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _marker.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
          infoWindow: InfoWindow(title: "Title of Marker:$i"),
          position: _latlong[i]));
      setState(() {});
    }
  }

  Future<Uint8List?> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final bytedata =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return bytedata!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custom Marker With NetworkImage',
          maxLines: 2,
        ),
      ),
      body: GoogleMap(
        markers: Set<Marker>.of(_marker),
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
