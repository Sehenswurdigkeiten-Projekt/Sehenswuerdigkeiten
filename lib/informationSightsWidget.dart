import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/loginScreen.dart';
import 'package:untitled/signUpScreen.dart';
import 'package:http/http.dart' as http;

class _informationSightsWidgetState extends State<informationSightsWidget>{
  var informationText="testText";
  var picture;
  var name;


  _informationSightsWidgetState(this.informationText, this.picture, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Column(
        children: [
          Text(
              name,
            style: TextStyle(
              fontFamily: 'Trazan Pro',
              fontSize: 17,
            ),
          ),
          Row(
            children: [
              Container(
                height: 130,
                width: 200,
                child: Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Flexible(
                      child: Text(informationText, style: TextStyle(fontSize: 15),),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Image.network(
                picture,
                height: 150,
                width: 150,
              ),
            ],
          ),
          //SizedBox(width: 100, height: 50),
        ],
      ),
    );
  }
}


class informationSightsWidget extends StatefulWidget {
    var informationText="friendname1";
    var picture;
    var name;

    informationSightsWidget(this.informationText, this.picture, this.name);

    _informationSightsWidgetState createState() => _informationSightsWidgetState(informationText, picture, name);
}

