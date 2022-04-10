import 'dart:developer';
//import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/informationSightsWidget.dart';
import 'globalVariables.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

List linkStored = [];

class poiInformationWindow extends StatefulWidget {
  @override
  State<poiInformationWindow> createState() => _poiInformationWindow();
}

class _poiInformationWindow extends State<poiInformationWindow> {

  late Future<List> informationsF = searchInfos();
  var informations;
  var linkImages;
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
    linkStored = [];
    for (int i = 0; i<poiLocationListLatLng.length; i++){
      //Für jeden Punkt die Informationen in das array informations schreiben

      //Name für Website bekommen
      qid = poiLocationListLatLng[i][2];
      //String nameUrl = "https://www.wikidata.org/w/api.php?action=wbgetentities&props=labels&ids=" + qid.toString()  +"&languages=de&format=json";
      String nameUrl = "https://www.wikidata.org/wiki/Special:EntityData/"+ qid.toString()+".json";
      final responseName = await http.get(Uri.parse(nameUrl)).timeout(Duration(seconds: 5));

      print("Name url: " + nameUrl.toString());
      print("Response Name request: " +responseName.body);
      Map<String, dynamic> jsonDataName = jsonDecode(responseName.body);

      if (jsonDataName['entities'][poiLocationListLatLng[i][2]]['labels']['en'] == null){
        print("There is no German description");
        infErg.add("There is no German description");
      }else{
        nameToFindWiki = (("${jsonDataName['entities'][poiLocationListLatLng[i][2]]['labels']['en']['value']}"));

        print("Name ausgelesen: ");
        print(("${jsonDataName['entities'][poiLocationListLatLng[i][2]]['labels']['en']['value']}"));

        //summary abfragen und speichern
        //https://en.wikipedia.org/api/rest_v1/page/summary/Stack_Overflow
        String summaryUrl = "https://de.wikipedia.org/api/rest_v1/page/summary/" + nameToFindWiki + "?format=json";
        print("SummaryURL: " + summaryUrl);
        final responeSummary = await http.get(Uri.parse(summaryUrl)).timeout(Duration(seconds: 10));

        Map<String, dynamic> jsonDataSummary = jsonDecode(responeSummary.body);
        log("Response summary:" + jsonDataSummary.toString());
        infErg.add(jsonDataSummary['extract'].toString());
        print("Link to image: " +jsonDataSummary['thumbnail']['source'].toString());
        print(linkStored);
        linkStored.add(jsonDataSummary['thumbnail']['source']);
        print("Infromation: " + infErg.toString());
      }
    }
    print("LinkStored: ");
    print(linkStored);
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
            if (!snapshot.hasData) return Center(child: Text("Select Points of Intrest"));
            else{
              return ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: informations.length,
                itemBuilder: (context, index){
                  return informationSightsWidget(informations[index], linkStored[index], poiLocationListLatLng[index][0].toString());
                  /*return Stack(
                    children: [
                      Center(
                          child: Text("lol dfjsdjfjkj dssdfkl"),
                      ),
                      Image.network(linkStored[index]),
                    ],
                  );*/
                },
              );
            }
          }
      )
    );
  }
}