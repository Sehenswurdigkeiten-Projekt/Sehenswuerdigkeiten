import 'dart:convert';
import 'dart:math';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:untitled/loginScreen.dart';
import 'package:untitled/signUpScreen.dart';


Future<LatLng?> acquireCurrentLocation() async {
  // Initializes the plugin and starts listening for potential platform events
  Location location = new Location();

  // Whether or not the location service is enabled
  bool serviceEnabled;

  // Status of a permission request to use location services
  PermissionStatus permissionGranted;

  // Check if the location service is enabled, and if not, then request it. In
  // case the user refuses to do it, return immediately with a null result
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  // Check for location permissions; similar to the workflow in Android apps,
  // so check whether the permissions is granted, if not, first you need to
  // request it, and then read the result of the request, and only proceed if
  // the permission was granted by the user
  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }
  // Gets the current location of the user
  final locationData = await location.getLocation();
  return LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
}


Future<List<dynamic>> acquireOthersLocation(LatLng myLocation) async {
  //print("Jetzt otherlocation function");
  //Connect to Server and get the location from the people
  var latlongs = [];
  var rng = Random();

  //myLocation = LatLng(55,55);

  //latlongs.add(LatLng(rng.nextDouble() * 90,rng.nextDouble() * 90));
  //latlongs.add(LatLng(rng.nextDouble() * 90,rng.nextDouble() * 90));

  latlongs = await requestServerFriendPos("http://185.5.199.33:30000/UPDATE_GPS", myLocation);
  //print("Jetzt die latlongs bekommen");
  //print(latlongs);


  return latlongs;
}
Future<List<dynamic>> requestServerFriendPos(String name, LatLng myLocation) async{
  String username = MyLoginWidget2.username;
  String token = MyLoginWidget2.token;

  //print("Jetzt in der requestServer");
  //print(MyLoginWidget2.token);
  //print(MyLoginWidget2.username);

  if(token == "") token = MySignupWidget2.token;
  if(username == "") username = MySignupWidget2.username;

  var body = {
    "username":"${username}",
    "token":"${token}",
    "lon": "${myLocation.longitude}",
    "lat": "${myLocation.latitude}",
    "toNotify":"-"
  };
  //print("DA");

  var client = new http.Client();
  var uri = Uri.parse(name);
  http.Response res = await client.post(uri, body: body);
  //print("DA2");
  //print(res.body);
  if(res.body.length == 0){
    return [];
  }

  var list = jsonDecode(res.body);
  //Da steht dann drinnen: lon, lat

  return list;
}