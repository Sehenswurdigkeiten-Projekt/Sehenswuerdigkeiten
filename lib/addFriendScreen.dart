
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:untitled/loginScreen.dart';
import 'package:untitled/signUpScreen.dart';

import 'friendRequestWidget.dart';

class MyFriendsWidget extends StatefulWidget {
  MyFriendsWidget({Key? key}) : super(key: key);


  @override
  State<MyFriendsWidget> createState() => _MyFriendsWidget();
}

class _MyFriendsWidget extends State<MyFriendsWidget> {

  TextEditingController friendsName = TextEditingController();
  TextEditingController groupName = TextEditingController();
  TextEditingController groupCode = TextEditingController();

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
                  Icons.emoji_people,
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
          Row(
              children: const [
                Icon(
                  Icons.people,
                  color: Color(0xff2F8D46),
                ),
                SizedBox(width: 10),
                Text(
                    "Groups",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ))
              ]
          ),
          Divider(height: 20, thickness: 1, color: Colors.grey[400]),
          SizedBox(height: 10),
          buildGroupOptionCreate(context, "Create Group"),
          buildGroupOptionJoin(context, "Join Group"),
          buildGroupOptionShow(context, "Show Groups"),
          buildGroupOptionMembers(context, "Show Group members"),
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
        String friendNameStr = "";
        var friendReqName = await checkIfCorrectRequest(false);
        Column friendsColumn = Column(
          children: [

          ],
        );

        print("IST NULL? = ${friendReqName} + ${friendReqName.length}");
        if(friendReqName.length == 1){
          friendNameStr = "No new friend requests!";
        }
        else{
          for(var i = 1; i<friendReqName.length; i++){
            print("$i");
            friendNameStr += friendReqName[i].toString() + "\n";
            print("$friendNameStr");

            friendsColumn.children.add(
              friendRequestWidget("${friendReqName[i]}", i-1)
            );
          }
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
                //Text("${friendNameStr}", textAlign: TextAlign.left, style: TextStyle(fontSize: 18),),
                friendsColumn,
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    List isCorrect = await checkIfCorrectRequest(true);
                    if(isCorrect[0] == false){
                      Alert(
                        type: AlertType.warning,
                        context: context,
                        title: "Something is wrong!",
                        desc: "Please correct it!",
                      ).show();
                    }
                    else{
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                      "Add all",
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

/////////////////////////////////////////////////////////

  GestureDetector buildGroupOptionCreate(BuildContext context, String title){
    return GestureDetector(
      onTap: () async {
        var isCorrect = await checkIfCorrectNewGroup();
        var code;
        code = isCorrect[1];
        var code2;
        code2 = jsonDecode(code)["code"].toString();
        if(isCorrect[0] == false){
          Alert(
            type: AlertType.warning,
            context: context,
            title: "Something is wrong!",
            desc: "Please correct it!",
          ).show();
          code2 = "";
        }
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$code2"
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

  GestureDetector buildGroupOptionJoin(BuildContext context, String title){
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

                  controller: groupName,

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
                    labelText: 'Group Code',
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
                    var isCorrect = await checkIfCorrectJoinGroup(groupName.text);
                    if(isCorrect == false){
                      Alert(
                        type: AlertType.warning,
                        context: context,
                        title: "Something is wrong!",
                        desc: "Please correct it!",
                      ).show();
                    }
                    else{
                      groupName.text = "";
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
                    groupName.text = "";
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

  GestureDetector buildGroupOptionShow(BuildContext context, String title){
    return GestureDetector(
      onTap: () async {
        var groups = await checkIfCorrectGroupShow();
        String groupsStr = "";
        for(var i = 0; i<groups.length; i++){
          groupsStr += groups[i].toString() + "\n";
        }
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  "Groups:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "$groupsStr",
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
          ],  //hehe
        ),
      ),
    );
  }

  GestureDetector buildGroupOptionMembers(BuildContext context, String title){
    return GestureDetector(
      onTap: () async{
        var stringmembers = "ff";
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

                  controller: groupCode,

                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[A-Za-zÀÁÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÆÐƎƏƐƔĲŊŒẞÞǷȜæðǝəɛɣĳŋœĸſßþƿȝĄƁÇĐƊĘĦĮƘŁØƠŞȘŢȚŦŲƯY̨Ƴąɓçđɗęħįƙłøơşșţțŧųưy̨ƴÁÀÂÄǍĂĀÃÅǺĄÆǼǢƁĆĊĈČÇĎḌĐƊÐÉÈĖÊËĚĔĒĘẸƎƏƐĠĜǦĞĢƔáàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣĤḤĦIÍÌİÎÏǏĬĪĨĮỊĲĴĶƘĹĻŁĽĿʼNŃN̈ŇÑŅŊÓÒÔÖǑŎŌÕŐỌØǾƠŒĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœŔŘŖŚŜŠŞȘṢẞŤŢṬŦÞÚÙÛÜǓŬŪŨŰŮŲỤƯẂẀŴẄǷÝỲŶŸȲỸƳŹŻŽẒŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ0-9_.-]')),
                    //FilteringTextInputFormatter.allow(RegExp('[A-Za-zÀÁÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÆÐƎƏƐƔĲŊŒẞÞǷȜæðǝəɛɣĳŋœĸſßþƿȝĄƁÇĐƊĘĦĮƘŁØƠŞȘŢȚŦŲƯY̨Ƴąɓçđɗęħįƙłøơşșţțŧųưy̨ƴÁÀÂÄǍĂĀÃÅǺĄÆǼǢƁĆĊĈČÇĎḌĐƊÐÉÈĖÊËĚĔĒĘẸƎƏƐĠĜǦĞĢƔáàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣĤḤĦIÍÌİÎÏǏĬĪĨĮỊĲĴĶƘĹĻŁĽĿʼNŃN̈ŇÑŅŊÓÒÔÖǑŎŌÕŐỌØǾƠŒĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœŔŘŖŚŜŠŞȘṢẞŤŢṬŦÞÚÙÛÜǓŬŪŨŰŮŲỤƯẂẀŴẄǷÝỲŶŸȲỸƳŹŻŽẒŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ0-9_.-]')),
                  ],

                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.people,
                      color: Color(0xff9a9a9a),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2F8D46)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2F8D46)),
                    ),
                    labelText: 'Group Code',
                    labelStyle: TextStyle(
                      color: Color(0xff9a9a9a),
                    ),
                  ),
                ),
                Text(
                  "Members:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  stringmembers,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    var isCorrect = await checkIfCorrectGroupMembersShow(groupCode.text);
                    print("hwgwg $isCorrect");
                    if(isCorrect[0] == false){
                      Alert(
                        type: AlertType.warning,
                        context: context,
                        title: "Something is wrong!",
                        desc: "Please correct it!",
                      ).show();
                    }
                    else{
                      groupCode.text = "";
                      print("SCHAUGMOMOL");
                      setState(() {
                        stringmembers = "${isCorrect[1]}";
                      });
                      //Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                      "Show",
                      style: TextStyle(
                        color: Color(0xff2F8D46),
                      ))
              ),
              TextButton(
                  onPressed: (){
                    groupCode.text = "";
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
Future<List> checkIfCorrectGroupMembersShow (String groupCode) async {
  var groups;
  var group;
  var isCorrect = false;

  var resArray = await requestServerGroupMembersShow(groupCode);
  groups = resArray[0];
  var statusCode = resArray[1];
  print(resArray);
  var length;

  if(groups != ""){
    length = jsonDecode(groups).length;
  }
  else{
    length = 0;
  }

  print(length);
  var ifCorrectArr = [];

  print("Hello $resArray");
  print(statusCode.runtimeType);
  if(statusCode != 415){
    isCorrect = true;
  }

  ifCorrectArr.add(isCorrect);
  for(var i = 0; i<length; i++){
    group = jsonDecode(groups)[i]["Username"].toString();
    //requestServer(friend);
    print("BIIIIITE: $group");
    ifCorrectArr.add(group);
  }

  print(ifCorrectArr);
  return ifCorrectArr;
}

Future<List<Object>> requestServerGroupMembersShow(String groupCode) async{
  String username = MyLoginWidget2.username;
  String token = MyLoginWidget2.token;

  print("Jetzt in der requestServer");

  if(token == "") token = MySignupWidget2.token;
  if(username == "") username = MySignupWidget2.username;

  var body = {
    "username":username,
    "token":token,
    "code":groupCode
  };
  var address = 'http://185.5.199.33:30000';
  print("!");
  var client = new http.Client();
  var uri = Uri.parse("$address/get_groupmembers");
  http.Response res = await client.post(uri, body: body);
  print("!");
  var resArray = [res.body, res.statusCode];

  print("RESARRAY2: ${resArray}");

  return resArray;
}

Future<List> checkIfCorrectGroupShow () async {
  var groups;
  var group;

  var resArray = await requestServerGroupShow();
  groups = resArray[0];
  var length = jsonDecode(groups).length;
  print(length);
  List<String> ifCorrectArr = [];

  print("Hello $resArray");

  for(var i = 0; i<length; i++){
    group = jsonDecode(groups)[i]["GroupCode"].toString();
    //requestServer(friend);
    print("BIIIIITE: $group");
    ifCorrectArr.add(group);
  }

  print(ifCorrectArr);

  return ifCorrectArr;
}

Future<List<Object>> requestServerGroupShow() async{
  String username = MyLoginWidget2.username;
  String token = MyLoginWidget2.token;

  print("Jetzt in der requestServer");

  if(token == "") token = MySignupWidget2.token;
  if(username == "") username = MySignupWidget2.username;

  var body = {
    "username":username,
    "token":token,
  };
  var address = 'http://185.5.199.33:30000';
  print("!");
  var client = new http.Client();
  var uri = Uri.parse("$address/get_groups");
  http.Response res = await client.post(uri, body: body);
  print("!");
  var resArray = [res.body, res.statusCode];

  print("RESARRAY2: ${resArray}");

  return resArray;
}

Future<List<Object>> checkIfCorrectNewGroup () async {
  bool isCorrect = false;

  var resArray = await requestServerNewGroup();
  var statusCode = resArray[1].toString();
  var groupCode = resArray[0].toString();

  if(statusCode != "404"){
    isCorrect = true;
  }

  var ifCorrectArr = [isCorrect, groupCode];
  print("ARR: $groupCode");
  //code = jsonDecode(ifCorrectArr)[i]["Username"].toString();
  return ifCorrectArr;
}

Future<List<Object>> requestServerNewGroup() async{
  String username = MyLoginWidget2.username;
  String token = MyLoginWidget2.token;

  print("Jetzt in der requestServer");
  if(token == "") token = MySignupWidget2.token;
  if(username == "") username = MySignupWidget2.username;

  var body = {
    "username":username,
    "token":token,
    "routeID":"hello" //(do amol uanfoch null übergeben)
  };

  var address = 'http://185.5.199.33:30000';
  var client = new http.Client();
  var uri = Uri.parse("$address/create_group");
  http.Response res = await client.post(uri, body: body);
  var resArray = [res.body, res.statusCode];

  print("RESARRAY2: ${resArray}");

  return resArray;
}

Future<bool> checkIfCorrectJoinGroup (groupCode) async {
  bool isCorrect = false;

  var resArray = await requestServerJoinGroup(groupCode);
  print(resArray);
  var statusCode = resArray[1].toString();
  print("STAT: $statusCode");

  if(statusCode != "405"){
    isCorrect = true;
  }
  print("COOR: $isCorrect");
  //code = jsonDecode(ifCorrectArr)[i]["Username"].toString();
  return isCorrect;
}

Future<List<Object>> requestServerJoinGroup(String groupCode) async{
  String username = MyLoginWidget2.username;
  String token = MyLoginWidget2.token;

  print("Jetzt in der requestServer");
  if(token == "") token = MySignupWidget2.token;
  if(username == "") username = MySignupWidget2.username;

  var body = {
    "username":username,
    "token":token,
    "code":groupCode
  };

  var address = 'http://185.5.199.33:30000';
  var client = new http.Client();
  var uri = Uri.parse("$address/join_group");
  http.Response res = await client.post(uri, body: body);
  var resArray = [res.body, res.statusCode];

  print("RESARRAY2: ${resArray}");

  return resArray;
}

/////////////////////////////////////////////////////

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

Future<List> checkIfCorrectRequest (bool adden) async {
  bool isCorrect = false;
  var alles = [];
  var ifCorrectArr = [];
  var friends;
  var friend;

  var resArray = await requestServerRequests();
  friends = resArray[0];
  var length = jsonDecode(friends).length;
  Object statusCode = resArray[1].toString();

  if(statusCode != "404" || statusCode != "403"){
    isCorrect = true;
  }

  ifCorrectArr.add(isCorrect);
  for(var i = 0; i<length; i++){
    friend = jsonDecode(friends)[i]["Username"].toString();
    if (adden == true){
      requestServer(friend);
    }
    ifCorrectArr.add(friend);
  }

  print("sdfsdfs $ifCorrectArr");
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