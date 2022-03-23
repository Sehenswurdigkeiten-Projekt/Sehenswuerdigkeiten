import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: FlutterMap(
          options: MapOptions(
            //center: latLng.LatLng(51.5, -0.09),
            //center: new LatLng(51.5, -0.09),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://api.mapbox.com/styles/v1/sehenswuerdigkeiten-proj/cl11y8pv5000f14m4pbcb826y/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2VoZW5zd3VlcmRpZ2tlaXRlbi1wcm9qIiwiYSI6ImNsMTBuY2E4djAwNjkzYm5zdjIwY3RpY3cifQ.blnV9_r4xomVn57TX0-i_g",
              additionalOptions: {
                'accessToken': 'pk.eyJ1Ijoic2VoZW5zd3VlcmRpZ2tlaXRlbi1wcm9qIiwiYSI6ImNsMTBuY2E4djAwNjkzYm5zdjIwY3RpY3cifQ.blnV9_r4xomVn57TX0-i_g',
                'id': 'mapbox.mapbox-streets-v8'
              },
              attributionBuilder: (_) {
                return Text("© OpenStreetMap contributors");
              },
            ),
            /*MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: latLng.LatLng(51.5, -0.09),
                builder: (ctx) =>
                    Container(
                      child: FlutterLogo(),
                    ),
              ),
            ],
          ),*/
          ],
        )
    );
  }
}
