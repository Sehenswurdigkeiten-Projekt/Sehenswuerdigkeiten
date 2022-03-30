import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:untitled/addFriendScreen.dart';
import 'package:untitled/http_service.dart';
import 'package:untitled/settingScreen.dart'; import 'locationstuff.dart';

class Suggestions{
  var _suggestions = [''];
}


class MyApp2 extends StatelessWidget {

  MyApp2({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom NavBar Demo',
      theme: ThemeData(
        primaryColor: const Color(0xff2F8D46),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class AutocompleteBar extends StatelessWidget{
  AutocompleteBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        Suggestions()._suggestions.clear();
        final res = await http.get(Uri.parse('https://public.opendatasoft.com/api/records/1.0/search/?dataset=geonames-all-cities-with-a-population-1000&q=&sort=name&facet=name&facet=cou_name_en&refine.alternate_names=${textEditingValue.text}'));

        if (res == '') {
          return Suggestions()._suggestions;
        }
        else {
          Map<String, dynamic> values = jsonDecode(res.body);
          for (var word in values['records']) {
            var field = word['fields'];
            Suggestions()._suggestions.add(field['name']);
            print(field['cou_name_en']);
            print(field['name']);
          }

          return Suggestions()._suggestions.where((String option) {
            return option.contains(textEditingValue.text.toLowerCase());
          });
        }
        },
        onSelected: (String selection){
        print('You just selected $selection');
        }
      );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var imageString = "assets/gps_images/gps_image0";
  int pageIndex = 0;

  Icon customIcon = const Icon(Icons.search);

  final pages = [
    MyFriendsWidget(),
    Page2(),
    MySettingWidget(),
  ];

  //GET_USERINFO:30000
  //body .> username, token -> res ist Bild auch.
  void updateProfilePicture(var name){
    imageString = name;

  }

  @override
  Widget build(BuildContext context) {
    Widget customSearchBar = Row(
      children: [
        Container(
            width: 50,
            height: 50,
            child: Image.asset(imageString)),
        SizedBox(width: 50),
        Text("One Trip"),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,

        automaticallyImplyLeading: false,
        actions: pageIndex == 1 ? [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: AutocompleteBar(),
                  );
                }  else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                            imageString,
                        ),
                      ),
                      SizedBox(width: 50),
                      Text("One Trip"),
                    ],
                  );
                }
              });
            },
            icon: customIcon,

          )
        ] : null,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }



  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        //color: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.group_rounded ,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.group_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.room_rounded,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.room_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.settings_rounded,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.settings_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Nummer 1",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Page21 extends StatelessWidget {
  const Page21({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Nummer 2",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Nummer 3",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}


class Page2 extends StatefulWidget {
  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late Timer timerOwnLocation;
  late Timer timerFriendLocation;
  late LatLng ownLocationLatLng;
  late List<dynamic> friendLocationListLatLng;

  late MapboxMapController mapboxmapcontroller; //Der controller für die Circles etc.
  var myColorCircle = '#006992';
  var otherColorCircle = '#009229';
  late Circle userCircle;
  late List friendListSymbols = [];
  final String token = 'pk.eyJ1Ijoic2VoZW5zd3VlcmRpZ2tlaXRlbi1wcm9qIiwiYSI6ImNsMTBuY2E4djAwNjkzYm5zdjIwY3RpY3cifQ.blnV9_r4xomVn57TX0-i_g';
  final String style = 'mapbox://styles/sehenswuerdigkeiten-proj/cl11y8pv5000f14m4pbcb826y';

  @override
  void initState() {
    //10.10.30.96:3000
    super.initState();
    timerOwnLocation = Timer.periodic(Duration(seconds: 1), (timer) async { //Hier der Timer zum updaten der eigenen Location!
      if(mapboxmapcontroller == null) return;
      //print("Eigene Location loading");

      ownLocationLatLng = (await acquireCurrentLocation())!;

      mapboxmapcontroller.updateCircle(userCircle, CircleOptions(
        circleRadius: 8.0,
        circleColor:  myColorCircle,
        circleOpacity: 0.8,
        geometry: ownLocationLatLng,
        draggable: false,
      )
      );
    });


    timerFriendLocation = Timer.periodic(Duration(seconds: 5), (timer) async { //Hier der Timer zum updaten der Freunde Location!
      if(mapboxmapcontroller == null) return;
      //print("Other Location Loading");
      friendLocationListLatLng = (await acquireOthersLocation(ownLocationLatLng));
      for(var i=0; i<friendListSymbols.length; i++){
        if(friendLocationListLatLng[i]['Lon'] == null || friendLocationListLatLng[i]['Lat'] == null) continue;

        mapboxmapcontroller.updateSymbol(friendListSymbols[i], SymbolOptions(
          iconSize: 0.4,
          iconImage: "assets/gps_images/${friendLocationListLatLng[i]['Image']}",
          iconOpacity: 0.8,
          textField: "${friendLocationListLatLng[i]["Username"]}",
          textOpacity: 0.8,
          textOffset: Offset(0,1),
          geometry: LatLng(friendLocationListLatLng[i]['Lat'], friendLocationListLatLng[i]['Lon']),
          draggable: false,
        ));
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    timerOwnLocation.cancel();
    timerFriendLocation.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        accessToken: token,
        styleString: style,
        initialCameraPosition: CameraPosition(
          zoom: 15.0,
          target: LatLng(14.508, 46.048),
        ),

        onMapCreated: (MapboxMapController controller) async {
          //print("jetzt in der onMapCreated");
          //Acquire current location (returns the LatLong instance)
          ownLocationLatLng = (await acquireCurrentLocation())!;

          // You can either use the moveCamera or animateCamera, but the former
          // causes a sudden movement from the initial to 'new' camera position,
          // while animateCamera gives a smooth animated transition
          await controller.animateCamera(
            CameraUpdate.newLatLng(ownLocationLatLng),
          );

          await controller.addCircle(
            CircleOptions(
              circleRadius: 8.0,
              circleColor: myColorCircle,
              circleOpacity: 0.8,
              geometry: ownLocationLatLng,
              draggable: false,
            ),
          );
          userCircle = controller.circles.first;
          friendLocationListLatLng = await acquireOthersLocation(ownLocationLatLng);

          //print("JEtzt locations");
          //print(friendLocationListLatLng);
          var geo;
          var anzeigen;

          for(var i=0; i<friendLocationListLatLng.length;i++){
            (friendLocationListLatLng[i]['Lat'] == null) ? geo = LatLng(0, 0) : geo = LatLng(friendLocationListLatLng[i]['Lat'], friendLocationListLatLng[i]['Lon']);
            (friendLocationListLatLng[i]['Lat'] == null) ? anzeigen = 0.0 : anzeigen = 0.8;

            await controller.addSymbol(
                SymbolOptions(
                    iconSize: 0.4,
                    iconImage: "assets/gps_images/${friendLocationListLatLng[i]['Image']}",
                    iconOpacity: anzeigen,
                    textField: "${friendLocationListLatLng[i]["Username"]}",
                    textOpacity: anzeigen,
                    textOffset: Offset(0,1),
                    geometry: geo,
                    draggable: false,
                )
            );

            friendListSymbols.add(controller.symbols.last);
          }


          //print("JETZT IST DIE oinMAPLOADIng function fertig");
          mapboxmapcontroller = controller;
          },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
            final res = await http.get(Uri.parse('https://public.opendatasoft.com/api/records/1.0/search/?dataset=geonames-all-cities-with-a-population-1000&q=&sort=name&facet=name&facet=cou_name_en&refine.alternate_names=Rom'));

            Map<String, dynamic> values = jsonDecode(res.body);
            for(var word in values['records']){
              var field = word['fields'];
              print(field['cou_name_en']);
              print(field['name']);

            }
            //print(values['records']);
            /*
            if(values.length > 0){
              for(var i = 0; i< values.length; i++){
                if(values[i]!=null){
                  Map<String, dynamic> map = values[i];
                  _postList.add(Post.fromJson(map));
                  print(map['name']);
                }
              }
            }

             */
            print("CITIES!");
            //print(cities);


          },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
    );


  }
}