import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:untitled/ImageGpsViewer.dart';
import 'package:untitled/loginScreen.dart';
import 'package:untitled/main.dart';
import 'package:untitled/mainstrukturwebseite.dart';
import 'package:untitled/mapboxAnzeige.dart';
import 'package:untitled/signUpScreen.dart';
import 'package:http/http.dart' as http;

class MySettingWidget extends StatefulWidget {
  MySettingWidget({Key? key}) : super(key: key);


  @override
  State<MySettingWidget> createState() => _MySettingWidget();
}

final settings = MySettingWidget();

class _MySettingWidget extends State<MySettingWidget> {

  TextEditingController changePass = TextEditingController();
  TextEditingController changePassConf = TextEditingController();

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
          buildAccountOptionPwd(context, "Change Password"),
          buildAccountOption(context, "Language"),
          buildAccountOption(context, "Privacy and Security"),
          SizedBox(height: 40),
          Row(
            children: const [
              Icon(
                  Icons.image,
                  color: Color(0xff2F8D46)
              ),
              SizedBox(width: 10),
              Text(
                "Profile Picture",
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
                Navigator.push(context, CupertinoPageRoute(builder: (context) => MyApp3()));
              },
              child: const Text(
                  "Add Profile Picture",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 2.2,
                    color: Colors.black,
                  )),
            ),
          ),
          SizedBox(height: 150),
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
                  MyLoginWidget2.token = "";
                  MyLoginWidget2.username = "";
                  Navigator.pop(context);
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => MyApp1()));
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp1()));
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
                  child: const Text(
                      "Close",
                      style: TextStyle(
                        color: Color(0xff2F8D46),
                      ))
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

  GestureDetector buildAccountOptionPwd(BuildContext context, String title){

    return GestureDetector(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  autofocus: false,
                  obscureText: true,
                  cursorColor: const Color(0xff9a9a9a),
                  maxLength: 20,

                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[A-Za-zÀÁÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÆÐƎƏƐƔĲŊŒẞÞǷȜæðǝəɛɣĳŋœĸſßþƿȝĄƁÇĐƊĘĦĮƘŁØƠŞȘŢȚŦŲƯY̨Ƴąɓçđɗęħįƙłøơşșţțŧųưy̨ƴÁÀÂÄǍĂĀÃÅǺĄÆǼǢƁĆĊĈČÇĎḌĐƊÐÉÈĖÊËĚĔĒĘẸƎƏƐĠĜǦĞĢƔáàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣĤḤĦIÍÌİÎÏǏĬĪĨĮỊĲĴĶƘĹĻŁĽĿʼNŃN̈ŇÑŅŊÓÒÔÖǑŎŌÕŐỌØǾƠŒĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœŔŘŖŚŜŠŞȘṢẞŤŢṬŦÞÚÙÛÜǓŬŪŨŰŮŲỤƯẂẀŴẄǷÝỲŶŸȲỸƳŹŻŽẒŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ0-9\$!#%&'*+,-./:;<=>?@^_`|~]")),
                  ],

                  controller: changePass,

                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.password,
                      color: Color(0xff9a9a9a),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2F8D46)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2F8D46)),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color(0xff9a9a9a),
                    ),
                  ),
                ),

                TextField(
                  autofocus: false,
                  obscureText: true,
                  cursorColor: const Color(0xff9a9a9a),
                  maxLength: 20,

                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[A-Za-zÀÁÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÆÐƎƏƐƔĲŊŒẞÞǷȜæðǝəɛɣĳŋœĸſßþƿȝĄƁÇĐƊĘĦĮƘŁØƠŞȘŢȚŦŲƯY̨Ƴąɓçđɗęħįƙłøơşșţțŧųưy̨ƴÁÀÂÄǍĂĀÃÅǺĄÆǼǢƁĆĊĈČÇĎḌĐƊÐÉÈĖÊËĚĔĒĘẸƎƏƐĠĜǦĞĢƔáàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣĤḤĦIÍÌİÎÏǏĬĪĨĮỊĲĴĶƘĹĻŁĽĿʼNŃN̈ŇÑŅŊÓÒÔÖǑŎŌÕŐỌØǾƠŒĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœŔŘŖŚŜŠŞȘṢẞŤŢṬŦÞÚÙÛÜǓŬŪŨŰŮŲỤƯẂẀŴẄǷÝỲŶŸȲỸƳŹŻŽẒŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ0-9\$!#%&'*+,-./:;<=>?@^_`|~]")),
                  ],

                  controller: changePassConf,

                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.password,
                      color: Color(0xff9a9a9a),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2F8D46)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2F8D46)),
                    ),
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                      color: Color(0xff9a9a9a),
                    ),
                  ),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () async{
                    bool isCorrect = await checkIfCorrect(changePass.text, changePassConf.text);
                    if (isCorrect == false){
                      Alert(
                        type: AlertType.warning,
                        context: context,
                        title: "Something is wrong!",
                        desc: "Please correct it!",
                      ).show();
                    }
                    else{
                      print(changePass.text);
                      print(changePassConf.text);

                      changePass.text = "";
                      changePassConf.text = "";

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Color(0xff2F8D46),
                      ))
              ),
              TextButton(
                  onPressed: (){
                    changePass.text = "";
                    changePassConf.text = "";
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      color: Color(0xff2F8D46),
                    ))
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

Future<bool> checkIfCorrect (String pass, String passConf) async {
  bool isCorrect = false;
  late Object token;
  late Object statusCode;

  if (pass != "" && passConf != "" && pass == passConf){
    var resArray = await requestServer(pass, passConf);
    token = resArray[0];
    statusCode = resArray[1].toString();

    if(statusCode == "200"){
      isCorrect = true;
    }
    print("DA!");
    print("TOKEN OBJ: $token");
    print("STATUSCODE: $statusCode");
  }

  return isCorrect;
}

Future<List<Object>> requestServer(String name, String pass) async{
  String username = MyLoginWidget2.username;
  String token = MyLoginWidget2.token;

  print("Jetzt in der requestServer");
  print(MyLoginWidget2.token);
  print(MyLoginWidget2.username);

  if(token == "") token = MySignupWidget2.token;
  if(username == "") username = MySignupWidget2.username;

  var body = {
    "username":username,
    "token":token,
    "pwd":pass
  };

  var address = 'http://185.5.199.33:30000';

  var client = new http.Client();
  var uri = Uri.parse("$address/change_password");
  http.Response res = await client.post(uri, body: body);

  var resArray = [res.body, res.statusCode];

  print("RESARRAY: $resArray");

  return resArray;
}