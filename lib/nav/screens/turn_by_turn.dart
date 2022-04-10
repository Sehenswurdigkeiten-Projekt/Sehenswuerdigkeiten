import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:untitled/globalVariables.dart';
import 'package:untitled/nav/helpers/shared_prefs.dart';

import '../../mainstrukturwebseite.dart';

class TurnByTurn extends StatefulWidget {
  const TurnByTurn({Key? key}) : super(key: key);

  @override
  State<TurnByTurn> createState() => _TurnByTurnState();
}

class _TurnByTurnState extends State<TurnByTurn> {
  // Waypoints to mark trip start and end
  late LatLng source; //getTripLatLngFromSharedPrefs('source');
  late LatLng destination; //getTripLatLngFromSharedPrefs('destination');
  late WayPoint sourceWaypoint, destinationWaypoint;
  var wayPoints = <WayPoint>[];

  // Config variables for Mapbox Navigation
  late MapBoxNavigation directions;
  late MapBoxOptions _options;
  late MapBoxNavigationViewController _controller;
  late double distanceRemaining, durationRemaining;
  bool isMultipleStop = false;
  String instruction = "";
  bool arrived = false;
  bool routeBuilt = false;
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    print("HERE");
    if (!mounted) return;

    // Setup directions and options
    directions = MapBoxNavigation(onRouteEvent: _onRouteEvent);
    _options = MapBoxOptions(
        zoom: 18.0,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        allowsUTurnAtWayPoints: true,
        alternatives: true,
        isOptimized: true,
        units: VoiceUnits.metric,
        simulateRoute: false,
        language: "en");

    //LatLng(double.parse(poiLocationListLatLng[i][6]), double.parse(poiLocationListLatLng[i][5]))

    // Configure waypoints
    //LatLng destination = new LatLng(double.parse(MapEntries.selectedCoordinates.split(',')[0]), double.parse(MapEntries.selectedCoordinates.split(',')[1]));
    LatLng destination = getDestinationLatLngFromSharedPrefs();
    sourceWaypoint = WayPoint(
        name: "Source", latitude: destination.latitude, longitude: destination.longitude);
    //var middleWayPoint = WayPoint(name: 'Middle', latitude: 46.7098951, longitude: 11.6497986);

    /*
    destinationWaypoint = WayPoint(
        name: "Destination",
        latitude: destination.latitude,
        longitude: destination.longitude);

     */
    isMultipleStop = true;

    wayPoints.add(sourceWaypoint);

    for(var i = 0; i < poiLocationListLatLng.length; i++){
      wayPoints.add(new WayPoint(name: i.toString(), latitude: double.parse(poiLocationListLatLng[i][6]), longitude: double.parse(poiLocationListLatLng[i][5])));
    }

    print(wayPoints);
    //wayPoints.add(middleWayPoint);
    //wayPoints.add(destinationWaypoint);

    // Start the trip
    await directions.startNavigation(wayPoints: wayPoints, options: _options);
  }

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }

  Future<void> _onRouteEvent(e) async {
    distanceRemaining = await directions.distanceRemaining;
    durationRemaining = await directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction!;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        arrived = true;
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        isNavigating = false;
        break;
      default:
        break;
    }
    //refresh UI
    setState(() {});
  }
}
