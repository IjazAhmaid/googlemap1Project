import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LatLongAddressConvertion extends StatefulWidget {
  const LatLongAddressConvertion({super.key});

  @override
  State<LatLongAddressConvertion> createState() =>
      _LatLongAddressConvertionState();
}

class _LatLongAddressConvertionState extends State<LatLongAddressConvertion> {
  final TextEditingController _controller = TextEditingController();
  String stAddress = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Google Map'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: _controller,
            ),
          ),
          GestureDetector(
            onTap: () async {
              List<Location> locations =
                  await locationFromAddress(_controller.text);

              setState(() {
                stAddress =
                    "${locations.reversed.last.latitude}${locations.reversed.last.longitude}";
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.green,
                height: 50,
                child: const Center(
                  child: Text("Convert"),
                ),
              ),
            ),
          ),
          Text(stAddress, maxLines: 1, softWrap: false),
        ],
      ),
    );
  }
}
