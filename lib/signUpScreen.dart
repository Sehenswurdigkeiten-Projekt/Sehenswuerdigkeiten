import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:untitled/HomePage.dart';
import 'package:untitled/loginScreen.dart';
import 'package:untitled/main.dart';
import 'package:untitled/mainstrukturwebseite.dart';
import 'package:untitled/mapboxAnzeige.dart';
import 'package:untitled/signUpScreen.dart';

class MySignupWidget extends StatefulWidget {
  const MySignupWidget({Key? key}) : super(key: key);

  @override
  State<MySignupWidget> createState() => _MySignupWidget();
}

class _MySignupWidget extends State<MySignupWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'One Trip',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Comfirm Password',
                ),
              ),
            ),

            Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  child: const Text('Sign Up'),
                  onPressed: () {
                    print("1");
                    bool isCorrect = checkIfCorrect(nameController.text, passwordController.text, confirmPasswordController.text);
                    print("2");
                    if(isCorrect == false) {
                      Alert(
                        context: context,
                        title: "Something is wrong!",
                        desc: "Please correct it!",
                      ).show();
                    }
                    else{
                      nameController.text = "";
                      passwordController.text = "";
                      confirmPasswordController.text = "";
                      _navigateToMap(context);
                      HomePage();
                    }
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text("Have an account?"),
                TextButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    nameController.text = "";
                    passwordController.text = "";
                    confirmPasswordController.text = "";
                    _navigateToNextScreen(context);
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));
  }
  void _navigateToMap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
  }
}
class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login'), toolbarHeight: 50,),
        body: MyLoginWidget()
    );
  }
}

bool checkIfCorrect (String name, String pass, String confPass){
  bool isCorrect = false;
  if(pass == confPass && name != "") {
    print("Name: " + name);
    print("Pass: " + pass);
    print("Conf Pass: " + confPass);
    isCorrect = true;
  }
  return isCorrect;
}