import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({super.key});

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  String maptheme = "";
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14.4746,
  );
  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/maptheme/default.json")
        .then((value) {
      maptheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString("assets/maptheme/default.json")
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Default Theme')),
              PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString("assets/maptheme/silvertheme.json")
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Silver Theme')),
              PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString("assets/maptheme/nighttheme.json")
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Night Theme')),
              PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString("assets/maptheme/retro_theme.json")
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Retro Theme')),
              PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString("assets/maptheme/darktheme.json")
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Dark Theme')),
              PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString("assets/maptheme/abergentheme.json")
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Abergen Theme'))
            ],
          )
        ],
        title: const Text('Theme of Google Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        compassEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(maptheme);
          _controller.complete(controller);
        },
      ),
    );
  }
}
