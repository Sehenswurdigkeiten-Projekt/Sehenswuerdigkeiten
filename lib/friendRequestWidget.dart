

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/loginScreen.dart';
import 'package:untitled/signUpScreen.dart';
import 'package:http/http.dart' as http;

class _friendRequestWidgetState extends State<friendRequestWidget>{
  var friendname="friendname1";
  var id;
  bool angenommen = false;


  _friendRequestWidgetState(this.friendname, this.id);

  @override
  Widget build(BuildContext context) {
    if(angenommen) return SizedBox(width: 60);

    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(alignment: Alignment.centerLeft ,child: Text(friendname)),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: (){
                print("Friend request abgelehnt bei id $id");
                setState(() {
                  angenommen = true;
                });
              },
              icon: Icon(Icons.cancel, color: Colors.red,)
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: (){
                print("Friend request angenommen bei id $id");
                requestServer(friendname);
                setState(() {
                  angenommen = true;
                });
              },
              icon: Icon(Icons.check_box, color: Colors.green)
          ),
        ),
      ],
    );
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
}


class friendRequestWidget extends StatefulWidget {
    var friendname="friendname1";
    var id;
    bool angenommen = false;

    friendRequestWidget(this.friendname, this.id);

    _friendRequestWidgetState createState() => _friendRequestWidgetState(friendname, id);
}

