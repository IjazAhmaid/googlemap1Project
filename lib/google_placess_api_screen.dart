import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacessApiScreen extends StatefulWidget {
  const GooglePlacessApiScreen({super.key});

  @override
  State<GooglePlacessApiScreen> createState() => _GooglePlacessApiScreenState();
}

class _GooglePlacessApiScreenState extends State<GooglePlacessApiScreen> {
  final TextEditingController _controller = TextEditingController();
  var uuid = const Uuid();
  // ignore: non_constant_identifier_names
  String _SessionToken = "009999";
  List<dynamic> _placessList = [];
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_SessionToken == null) {
      setState(() {
        _SessionToken = uuid.v4();
      });
    }
    getSugesstion(_controller.text.toString());
  }

  void getSugesstion(String input) async {
    String kplacesApiKey = "AIzaSyC2fCbbjH7a1Mf0ApU-Co6wFBI2dVSM_Uc";

    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kplacesApiKey&sessiontoken=$_SessionToken';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print('data');
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        _placessList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Faild To Load");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Google Placess Api"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration:
                  const InputDecoration(hintText: "Google Search Places Api"),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _placessList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    List<Location> locations = await locationFromAddress(
                        _placessList[index]['description']);
                    print(locations.last.latitude);
                    print(locations.last.longitude);
                  },
                  title: Text(_placessList[index]['description']),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
