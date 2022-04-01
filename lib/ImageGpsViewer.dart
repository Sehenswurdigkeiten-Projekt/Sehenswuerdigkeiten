import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled/loginScreen.dart';
import 'package:untitled/mainstrukturwebseite.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/signUpScreen.dart';



void main() => runApp(MyApp3());

class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery Demo',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: DisplayPage(),
    );
  }
}

class DisplayPage extends StatelessWidget {
  static var _final_page_index=0;

  final List<String> images = [
    "assets/gps_images/gps_image0.png",
    "assets/gps_images/gps_image1.png",
    "assets/gps_images/gps_image2.png",
    "assets/gps_images/gps_image3.png",
    "assets/gps_images/gps_image4.png",
    "assets/gps_images/gps_image5.png",
    "assets/gps_images/gps_image6.png",
    "assets/gps_images/gps_image7.png",
    "assets/gps_images/gps_image8.png",
    "assets/gps_images/gps_image9.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
          child: ListView(
            padding: EdgeInsets.only(top: 150),
            children: <Widget>[
              Center(
              child: SizedBox.fromSize(
                size: Size.fromHeight(550.0),
                child: PageView.builder(
                  onPageChanged: (var page){
                    _final_page_index = page;
                  },
                  controller: PageController(viewportFraction: 0.8),
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 8.0,
                      ),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: FractionalOffset.bottomCenter,
                                  end: FractionalOffset.topCenter,
                                  colors: [
                                    Color(0x00000000).withOpacity(0.0),
                                    Color(0xff000000).withOpacity(0.0),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xffBDBDBD)),
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                onPressed: () async {
                  await requestServerSendNewPic("http://185.5.199.33:30000/UPDATE_IMAGE");
                  HomePageState.homePageState.updateProfilePicture("assets/gps_images/gps_image${final_index}.png");

                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp2()));
                },
                child: const Text(
                    "Select this Image",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 2.2,
                      color: Colors.black,
                    )),
              )
            ],
          )
      ),
    );
  }

  Future<void> requestServerSendNewPic(String name) async{
    String username = MyLoginWidget2.username;
    String token = MyLoginWidget2.token;

    if(token == "") token = MySignupWidget2.token;
    if(username == "") username = MySignupWidget2.username;

    var body = {
      "username":"${username}",
      "token":"${token}",
      "image": "gps_image${_final_page_index}.png",
    };

    var client = new http.Client();
    var uri = Uri.parse(name);
    http.Response res = await client.post(uri, body: body);

    print("JETZT FERTIG");
    print(res);

    return;
  }


  static get final_index => _final_page_index;
}
