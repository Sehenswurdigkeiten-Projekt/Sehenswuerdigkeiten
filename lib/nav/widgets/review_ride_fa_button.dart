import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:untitled/mainstrukturwebseite.dart';

import '../../locationstuff.dart';
import '../helpers/mapbox_handler.dart';
import '../helpers/shared_prefs.dart';
import '../screens/review_ride.dart';

Widget reviewRideFaButton(BuildContext context) {
  return FloatingActionButton.extended(
      icon: const Icon(Icons.local_taxi),
      onPressed: () async {
        LatLng? sourceLatLng = getCurrentLatLngFromSharedPrefs();
        LatLng destinationLatLng = getDestinationLatLngFromSharedPrefs();

        Map modifiedResponse =
            await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    ReviewRide(modifiedResponse: modifiedResponse)));
      },
      label: const Text('Review Ride'));
}
