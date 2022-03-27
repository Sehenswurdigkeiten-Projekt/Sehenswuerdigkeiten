import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart'; import 'locationstuff.dart';


class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final pages = [
    const Page1(),
    Page2(),
    const Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC4DFCB),
      appBar: AppBar(
        // leading: Icon(
        //  Icons.menu,
        //   color: Theme.of(context).primaryColor,
        // ),
        title: Text(
          "Chefs",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
  late List friendListCircle = [];
  final String token = 'pk.eyJ1Ijoic2VoZW5zd3VlcmRpZ2tlaXRlbi1wcm9qIiwiYSI6ImNsMTBuY2E4djAwNjkzYm5zdjIwY3RpY3cifQ.blnV9_r4xomVn57TX0-i_g';
  final String style = 'mapbox://styles/sehenswuerdigkeiten-proj/cl11y8pv5000f14m4pbcb826y';

  @override
  void initState() {
    //10.10.30.96:3000
    super.initState();
    timerOwnLocation = Timer.periodic(Duration(seconds: 1), (timer) async { //Hier der Timer zum updaten der eigenen Location!
      if(mapboxmapcontroller == null) return;
      print("Eigene Location loading");

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
      print("Other Location Loading");
      friendLocationListLatLng = (await acquireOthersLocation(ownLocationLatLng));
      for(var i=0; i<friendListCircle.length; i++){
        if(friendLocationListLatLng[i]['Lon'] == null || friendLocationListLatLng[i]['Lat'] == null) continue;

        mapboxmapcontroller.updateCircle(friendListCircle[i], CircleOptions(
          circleRadius: 8.0,
          circleColor:  otherColorCircle,
          circleOpacity: 0.8,
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
          print("jetzt in der onMapCreated");
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

          print("JEtzt locations");
          print(friendLocationListLatLng);
          var geo;
          var anzeigen;

          for(var i=0; i<friendLocationListLatLng.length;i++){
            (friendLocationListLatLng[i]['Lat'] == null) ? geo = LatLng(0, 0) : geo = LatLng(friendLocationListLatLng[i]['Lat'], friendLocationListLatLng[i]['Lon']);
            (friendLocationListLatLng[i]['Lat'] == null) ? anzeigen = 0.0 : anzeigen = 0.8;

            await controller.addCircle(
              CircleOptions(
                circleRadius: 8.0,
                circleColor: otherColorCircle,
                circleOpacity: anzeigen,
                geometry: geo,
                draggable: false,
              ),
            );

            friendListCircle.add(controller.circles.last);
          }
          print("JETZT IST DIE oinMAPLOADIng function fertig");
          mapboxmapcontroller = controller;
        },

      ),
    );


  }
}