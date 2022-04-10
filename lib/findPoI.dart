import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';


class FindPoI{
  Future<List> searchPoI(var cityName, var startLon, var startLat, ) async{
    //Lon = 11.422465473888776
    //Lat = 46.890633738573584
    print("start FindPoI");
    var limit = 0, offset = 0, radius = 10000;
    var lon = "", lat = "";

    lon = startLon;
    lat = startLat;

    //search for points of intrest:
    String url;
    if (limit == 0) url = "https://api.opentripmap.com/0.1/en/places/radius?apikey=5ae2e3f221c38a28845f05b633b956e2d752edfeef3e68b5192bf605&limit&offset=" + offset.toString() +"&radius=" +radius.toString()+"&lon="+lon+"&lat="+lat+"&rate=2&format=geojson";
    else url = "https://api.opentripmap.com/0.1/en/places/radius?apikey=5ae2e3f221c38a28845f05b633b956e2d752edfeef3e68b5192bf605&limit=" + limit.toString() + "&offset=" + offset.toString() +"&radius=" +radius.toString()+"&lon="+lon+"&lat="+lat+"&rate=2&format=geojson";
    final responsePOI = await http.get(Uri.parse(url));

    if (responsePOI.statusCode == 200) {
      Map<String, dynamic> jsonDataPOI = jsonDecode(responsePOI.body);
      if(limit == 0) limit = jsonDataPOI['features'].length;
      var results = List.generate(limit, (i) => List.filled(7, "", growable: false), growable: true);
      //[[wikidata][kinds][name][lat][lon][rate][dist]]
      for(var i = 0; i <results.length; i++){
        for(var c = 0; c <results[i].length; c++){
          switch (c){
            case 0:
              results[i][c] = ("${jsonDataPOI['features'][i]['properties']['name']}");
              break;
            case 1:
              results[i][c] = ("${jsonDataPOI['features'][i]['properties']['rate']}");
              break;
            case 2:
              results[i][c] = ("${jsonDataPOI['features'][i]['properties']['wikidata']}");
              break;
            case 3:
              results[i][c] = ("${jsonDataPOI['features'][i]['properties']['rate']}");
              break;
            case 4:
              results[i][c] = ("${jsonDataPOI['features'][i]['properties']['kinds']}");
              break;
            case 5:
              results[i][c] = ("${jsonDataPOI['features'][i]['geometry']['coordinates'][0]}");
              break;
            case 6:
              results[i][c] = ("${jsonDataPOI['features'][i]['geometry']['coordinates'][1]}");
              break;
          }
        }
        print("Ausgabe:");
        for (var x = 0; x<results.length; x++){
          print(results[x]);
        }
      }
      print("results");
      print(results);
      return results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
