
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:untitled/loginScreen.dart';
import 'package:untitled/signUpScreen.dart';

class MyFriendsWidget extends StatefulWidget {
  MyFriendsWidget({Key? key}) : super(key: key);


  @override
  State<MyFriendsWidget> createState() => _MyFriendsWidget();
}

class _MyFriendsWidget extends State<MyFriendsWidget> {

  TextEditingController friendsName = TextEditingController();

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
              'Friends/Groups',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),//
            ),
          ),
          Row(
              children: const [
                Icon(
                  Icons.people,
                  color: Color(0xff2F8D46),
                ),
                SizedBox(width: 10),
                Text(
                    "Friends",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ))
              ]
          ),
          Divider(height: 20, thickness: 1, color: Colors.grey[400]),
          SizedBox(height: 10),
          buildFriendOptionAdd(context, "Add Friends"),
          buildFriendOptionRequests(context, "Show Friend Requests"),
          buildFriendOptionShow(context, "Show Friends"),
          SizedBox(height: 40),
        ]
      )
    );
  }

  GestureDetector buildFriendOptionAdd(BuildContext context, String title){
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
                  cursorColor: const Color(0xff9a9a9a),
                  maxLength: 20,

                  controller: friendsName,

                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[A-Za-zÀÁÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÆÐƎƏƐƔĲŊŒẞÞǷȜæðǝəɛɣĳŋœĸſßþƿȝĄƁÇĐƊĘĦĮƘŁØƠŞȘŢȚŦŲƯY̨Ƴąɓçđɗęħįƙłøơşșţțŧųưy̨ƴÁÀÂÄǍĂĀÃÅǺĄÆǼǢƁĆĊĈČÇĎḌĐƊÐÉÈĖÊËĚĔĒĘẸƎƏƐĠĜǦĞĢƔáàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣĤḤĦIÍÌİÎÏǏĬĪĨĮỊĲĴĶƘĹĻŁĽĿʼNŃN̈ŇÑŅŊÓÒÔÖǑŎŌÕŐỌØǾƠŒĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœŔŘŖŚŜŠŞȘṢẞŤŢṬŦÞÚÙÛÜǓŬŪŨŰŮŲỤƯẂẀŴẄǷÝỲŶŸȲỸƳŹŻŽẒŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ0-9_.-]')),
                    //FilteringTextInputFormatter.allow(RegExp('[A-Za-zÀÁÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÆÐƎƏƐƔĲŊŒẞÞǷȜæðǝəɛɣĳŋœĸſßþƿȝĄƁÇĐƊĘĦĮƘŁØƠŞȘŢȚŦŲƯY̨Ƴąɓçđɗęħįƙłøơşșţțŧųưy̨ƴÁÀÂÄǍĂĀÃÅǺĄÆǼǢƁĆĊĈČÇĎḌĐƊÐÉÈĖÊËĚĔĒĘẸƎƏƐĠĜǦĞĢƔáàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣĤḤĦIÍÌİÎÏǏĬĪĨĮỊĲĴĶƘĹĻŁĽĿʼNŃN̈ŇÑŅŊÓÒÔÖǑŎŌÕŐỌØǾƠŒĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœŔŘŖŚŜŠŞȘṢẞŤŢṬŦÞÚÙÛÜǓŬŪŨŰŮŲỤƯẂẀŴẄǷÝỲŶŸȲỸƳŹŻŽẒŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ0-9_.-]')),
                  ],

                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.person_add,
                      color: Color(0xff9a9a9a),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2F8D46)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2F8D46)),
                    ),
                    labelText: 'Friend Name',
                    labelStyle: TextStyle(
                      color: Color(0xff9a9a9a),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    String username = MyLoginWidget2.username;
                    bool isCorrect = await checkIfCorrect(friendsName.text);
                    if(isCorrect == false || friendsName.text == username){
                      Alert(
                        type: AlertType.warning,
                        context: context,
                        title: "Something is wrong!",
                        desc: "Please correct it!",
                      ).show();
                      friendsName.text = "";
                    }
                    else{
                      print(friendsName.text);

                      friendsName.text = "";

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                      "Add",
                      style: TextStyle(
                        color: Color(0xff2F8D46),
                      ))
              ),
              TextButton(
                  onPressed: (){
                    friendsName.text = "";
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

  GestureDetector buildFriendOptionShow(BuildContext context, String title){
    return GestureDetector(
      onTap: () async {
        var friends = await checkIfCorrectShow();
        String friendStr = "";
        for(var i = 0; i<friends.length; i++){
          friendStr += friends[i].toString() + "\n";
        }

        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Friends:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "$friendStr",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
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
              ),
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

  GestureDetector buildFriendOptionRequests(BuildContext context, String title){
    return GestureDetector(
      onTap: () async {
        var friendReqName = await checkIfCorrectRequest();
        print("IST NULL? = ${friendReqName[1]}");
        if(friendReqName[1] == null){
          friendReqName[1] = "No new friend requests!";
        }
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Friends:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${friendReqName[1]}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    List isCorrect = await checkIfCorrectRequest();
                    if(isCorrect[0] == false){
                      Alert(
                        type: AlertType.warning,
                        context: context,
                        title: "Something is wrong!",
                        desc: "Please correct it!",
                      ).show();
                    }
                    else{
                      //checkIfCorrect();

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                      "Add",
                      style: TextStyle(
                        color: Color(0xff2F8D46),
                      ))
              ),
              TextButton(
                  onPressed: (){
                    friendsName.text = "";
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

Future<bool> checkIfCorrect (String friend) async {
  bool isCorrect = false;
  late Object token;
  String username = MyLoginWidget2.username;

  print("Friend: $friend");
  if(friend != "" && friend != username) {
    var resArray = await requestServer(friend);
    token = resArray[0];
    Object statusCode = resArray[1].toString();

    if(statusCode != "403"){
      isCorrect = true;
    }
  }
  print(isCorrect);

  return isCorrect;
}

Future<List<Object>> requestServer(String friend) async{
  String username = MyLoginWidget2.username;
  String token = MyLoginWidget2.token;

  print("Jetzt in der requestServer");
  print(MyLoginWidget2.token);
  print(MyLoginWidget2.username);

  if(token == "") token = MySignupWidget2.token;
  if(username == "") username = MySignupWidget2.username;

  var body = {
    "username":username,
    "friend":friend,
    "token":token,
  };

  var address = 'http://185.5.199.33:30000';

  var client = new http.Client();
  var uri = Uri.parse("$address/add_friend");
  http.Response res = await client.post(uri, body: body);

  var resArray = [res.body, res.statusCode];

  print("RESARRAY: $resArray");

  return resArray;
}

Future<List> checkIfCorrectRequest () async {
  bool isCorrect = false;
  var friends;
  var friend;

  var resArray = await requestServerRequests();
  friends = resArray[0];
  var length = jsonDecode(friends).length;


  for(var i = 0; i<length; i++){
    friend = jsonDecode(friends)[i]["Username"].toString();
    requestServer(friend);
  }

  Object statusCode = resArray[1].toString();

  if(statusCode != "404" || statusCode != "403"){
    isCorrect = true;
  }
  var ifCorrectArr = [isCorrect, friend];

  return ifCorrectArr;
}

Future<List<Object>> requestServerRequests() async{
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
  };

  var address = 'http://185.5.199.33:30000';

  var client = new http.Client();
  var uri = Uri.parse("$address/get_friendrequests");
  http.Response res = await client.post(uri, body: body);

  var resArray = [res.body, res.statusCode];

  print("RESARRAY2: ${resArray}");

  return resArray;
}

Future<List> checkIfCorrectShow () async {
  var friends;
  var friend;

  var resArray = await requestServerShow();
  friends = resArray[0];
  var length = jsonDecode(friends).length;
  print(length);
  List<String> ifCorrectArr = [];

  print(resArray);

  for(var i = 0; i<length; i++){
    friend = jsonDecode(friends)[i]["Username"].toString();
    //requestServer(friend);
    print("BIIIIITE: $friend");
    ifCorrectArr.add(friend);
  }

  print(ifCorrectArr);

  return ifCorrectArr;
}

Future<List<Object>> requestServerShow() async{
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
  };

  var address = 'http://185.5.199.33:30000';

  var client = new http.Client();
  var uri = Uri.parse("$address/get_friends");
  http.Response res = await client.post(uri, body: body);

  var resArray = [res.body, res.statusCode];

  print("RESARRAY2: ${resArray}");

  return resArray;
}