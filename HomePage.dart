import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomePageDep extends StatefulWidget {
  @override
  _HomePageDepState createState() => _HomePageDepState();
}

class _HomePageDepState extends State<HomePageDep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5074, 0.1278), // London
          zoom: 16.0,
          minZoom: 10,
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: 'TODO',
          ),
        ],
      ),
    );
  }
}