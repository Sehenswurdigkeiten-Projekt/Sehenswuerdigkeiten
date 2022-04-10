import 'dart:developer';
//import 'dart:math';

import 'package:flutter/material.dart';
import 'globalVariables.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class poiInformationWindow extends StatefulWidget {
  @override
  State<poiInformationWindow> createState() => _poiInformationWindow();
}

class _poiInformationWindow extends State<poiInformationWindow> {

  late Future<List> informationsF = searchInfos();
  var informations;
  var nameToFindWiki;
  ScrollController _scrollController = new ScrollController();

  void initState(){
    super.initState();
    print("search for information on POIs");
    _getInfos().then(
        (value){
          if(value != null)
            setState(() {
              informations = value;
            });
        }
    );
    print("Got all the informations: " + informations.toString());
  }

  Future<List> _getInfos() async{
    print("get informations");
    return await informationsF.then((value) {
      return value;
    });
  }


  Future<List> searchInfos() async{
    List infErg = [];
    var qid = "";
    for (int i = 0; i<rutePoints.length; i++){
      //Für jeden Punkt die Informationen in das array informations schreiben

      //Name für Website bekommen
      qid = rutePoints[i][2];
      String nameUrl = "https://www.wikidata.org/w/api.php?action=wbgetentities&props=labels&ids=" + qid.toString()  +"&languages=de&format=json";
      final responseName = await http.get(Uri.parse(nameUrl)).timeout(Duration(seconds: 5));

      print("Response Name request: " +responseName.body);
      Map<String, dynamic> jsonDataName = jsonDecode(responseName.body);
      nameToFindWiki = (("${jsonDataName['entities'][rutePoints[i][2]]['labels']['de']['value']}"));
      print("Name ausgelesen: ");
      print(("${jsonDataName['entities'][rutePoints[i][2]]['labels']['de']['value']}"));

      //summary abfragen und speichern
      //https://en.wikipedia.org/api/rest_v1/page/summary/Stack_Overflow
      String summaryUrl = "https://de.wikipedia.org/api/rest_v1/page/summary/" + nameToFindWiki + "?format=json";
      final responeSummary = await http.get(Uri.parse(summaryUrl)).timeout(Duration(seconds: 10));

      Map<String, dynamic> jsonDataSummary = jsonDecode(responeSummary.body);
      log("Response summary:" + jsonDataSummary['extract'].toString());
      infErg.add(jsonDataSummary['extract'].toString());
      print("Infromation: " + infErg.toString());
    }
    return infErg;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Detailed information'),
      ),

      body: FutureBuilder(
          future: informationsF,
          builder: (context, snapshot){
            if (!snapshot.hasData) return Center(child: Text("Select Points of Interest"));
            else{
              return ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: informations.length,
                itemBuilder: (context, index){
                  return Text(
                    informations[index]
                  );
                },
              );
            }
          }
      )
    );
  }
}