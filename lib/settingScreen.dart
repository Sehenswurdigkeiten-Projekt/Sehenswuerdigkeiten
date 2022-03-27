import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:untitled/loginScreen.dart';
import 'package:untitled/main.dart';
import 'package:untitled/mapboxAnzeige.dart';
import 'package:untitled/signUpScreen.dart';

class MySettingWidget extends StatefulWidget {
  MySettingWidget({Key? key}) : super(key: key);

  final TextEditingController themeController = TextEditingController();

  @override
  State<MySettingWidget> createState() => _MySettingWidget();
}

final settings = MySettingWidget();

class _MySettingWidget extends State<MySettingWidget> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  onChangeFunction1(bool newValue1){
    setState(() {
      print("value: $newValue1");
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2){
    setState(() {
      print("value: $newValue2");
      valNotify2= newValue2;
    });
  }

  onChangeFunction3(bool newValue3){
    setState(() {
      print("value: $newValue3");
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffe9ecef),
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: const Text(
                'Settings',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),//
              ),
          ),
          Row(
            children: const [
              Icon(
                Icons.person,
                color: Color(0xff2F8D46),
              ),
              SizedBox(width: 10),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))
            ]
          ),
          Divider(height: 20, thickness: 1, color: Colors.grey[400]),
          SizedBox(height: 10),
          buildAccountOption(context, "Change Password"),
          buildAccountOption(context, "Language"),
          buildAccountOption(context, "Privacy and Security"),
          SizedBox(height: 40),
          Row(
            children: const [
              Icon(
                  Icons.volume_up_outlined,
                  color: Color(0xff2F8D46)
              ),
              SizedBox(width: 10),
              Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),
          Divider(height: 20, thickness: 1, color: Colors.grey[400]),
          SizedBox(height: 49),
          buildNotificationOption("Theme Dark", valNotify1, onChangeFunction1),
          buildNotificationOption("Text 1", valNotify2, onChangeFunction2),
          buildNotificationOption("Text 2", valNotify3, onChangeFunction3),
          SizedBox(height: 50),
          Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xffBDBDBD)),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              onPressed: (){
                Future.delayed(const Duration(milliseconds: 1000), () {
                  Navigator.pop(context, MyLoginWidget());
                });
              },
              child: const Text(
                "SIGN OUT",
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 2.2,
                  color: Colors.black,
                )),
            ),
          )
        ],
      ),
    );
  }

  Padding buildNotificationOption(String title, bool value, Function onChangeMethod){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600]
              ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Color(0xff2F8D46),
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue){
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title){
    return GestureDetector(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("Option 1"),
                Text("Option 2")
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Close")
              )
            ],
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]
            )),
            Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}