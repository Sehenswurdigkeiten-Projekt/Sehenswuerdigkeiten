import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:untitled/HomePage.dart';
import 'package:untitled/main.dart';
import 'package:untitled/mainstrukturwebseite.dart';
import 'package:untitled/signUpScreen.dart';

class MyLoginWidget extends StatefulWidget {
  const MyLoginWidget({Key? key}) : super(key: key);

  @override
  State<MyLoginWidget> createState() => _MyLoginWidget();
}

class _MyLoginWidget extends State<MyLoginWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  'Login',
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
                height: 70,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    bool isCorrect = checkIfCorrect(nameController.text, passwordController.text);
                    if (isCorrect == false){
                      Alert(
                        context: context,
                        title: "Something is wrong!",
                        desc: "Please correct it!",
                      ).show();
                    }
                    else{
                      print(nameController.text);
                      print(passwordController.text);
                      nameController.text = "";
                      passwordController.text = "";
                      _navigateToMap(context);
                    }
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text("Don't have an account?"),
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    nameController.text = "";
                    passwordController.text = "";
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
      appBar: AppBar(title: Text('Sign Up'), toolbarHeight: 50,),
      body: MySignupWidget()
    );
  }
}

bool checkIfCorrect (String name, String pass){
  bool isCorrect = false;
  if (name != "" && pass != ""){
    isCorrect = true;
  }
  return isCorrect;
}