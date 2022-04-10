import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:untitled/globalVariables.dart';
import 'package:untitled/nav/helpers/shared_prefs.dart';

import '../helpers/dio_exceptions.dart';

String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
String accessToken = 'pk.eyJ1Ijoic2VoZW5zd3VlcmRpZ2tlaXRlbi1wcm9qIiwiYSI6ImNsMTBuY2E4djAwNjkzYm5zdjIwY3RpY3cifQ.blnV9_r4xomVn57TX0-i_g';
String navType = 'driving-traffic';

Dio _dio = Dio();

Future getCyclingRouteUsingMapbox() async {
  var points = '';
  for(var i = 0; i < poiLocationListLatLng.length; i++){
    points += poiLocationListLatLng[i][5] + ',' + poiLocationListLatLng[i][6] + ';';
  }
  points = points.substring(0, points.length - 1);

 // String url =
    //  '$baseUrl/$navType/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';
  String url = '$baseUrl/$navType/${getDestinationLatLngFromSharedPrefs().longitude.toString()},${getDestinationLatLngFromSharedPrefs().latitude.toString()};$points?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';


  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    return responseData.data;
  } catch (e) {
    final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
    debugPrint(errorMessage);
  }
}
