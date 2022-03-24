import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:untitled/mainstrukturwebseite.dart';
import 'package:untitled/signUpScreen.dart';
import 'package:http/http.dart' as http;

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
    return Container(
      color: const Color(0xFF424242),//color: Color(0xFF424242),0xFFE0E0E0
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: const Text(
                  'One Trip',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),//
                )),
            Container(
              child: Column(children: <Widget>[
                Container(
                  width: 150,
                  margin: const EdgeInsets.all(10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                    child: Image.asset('assets/images/logo6.png')
                  ),
                ),
              ]),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 21),
                )),
            Container( //https://medium.com/flutter-community/a-visual-guide-to-input-decorations-for-flutter-textfield-706cf1877e25
              padding: const EdgeInsets.all(10),
              child: TextField(
                autofocus: false,
                controller: nameController,
                cursorColor: const Color(0xff9a9a9a),
                maxLength: 20,

                decoration: const InputDecoration(
                  counterText: "", //Damit 0/20 weckfällt
                  suffixIcon: Icon( //Account Icon
                    Icons.account_circle_outlined,  //welches
                    color: Color(0xff9a9a9a),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff2F8D46)), //normale Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff2F8D46)), //Wenn man hineinklickt color
                  ),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                      color: Color(0xff9a9a9a)
                  ),

                  /*
                  labelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                    final color = states.contains(MaterialState.error)? Theme.of(context).errorColor: const Color(0xff2F8D46);
                    return TextStyle(color: color, letterSpacing: 1.3);
                  }),
                   */
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                autofocus: false,
                obscureText: true,
                cursorColor: const Color(0xff9a9a9a),
                maxLength: 20,

                controller: passwordController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.password,
                    color: Color(0xff9a9a9a),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff2F8D46)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff2F8D46)),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xff9a9a9a),
                  ),
                ),
              ),
            ),

            Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff2F8D46)),
                  ),
                  child: const Text('Login'),
                  onPressed: () {
                    bool isCorrect = checkIfCorrect(nameController.text, passwordController.text); //checkt ob überall etwas eingegeben wurde und es richtig ist
                    if (isCorrect == false){
                      Alert(
                        type: AlertType.warning,
                        context: context,
                        title: "Something is wrong!",
                        desc: "Please correct it!",
                      ).show();
                    }
                    else{
                      print(nameController.text);
                      print(passwordController.text);

                      String jsonString = '{"username":"${nameController.text}","pwd":"${passwordController.text}"}';

                      print(jsonString); // Dart

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
                    style: TextStyle(fontSize: 20, color: Color(0xff2F8D46)),
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
        ),
    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));
  }
  void _navigateToMap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
  }
}

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: const MySignupWidget()
    );
  }
}

bool checkIfCorrect (String name, String pass){
  bool isCorrect = false;
  //var data = getDataFromServer() --> für die richtigen daten oder so
  var data = ['{"username":"hans","pwd":"pass1"}','{"username":"Larcher","pwd":"pass2"}'];
  //name, pass

  if (name != "" && pass != ""){
    isCorrect = true;
  }
  return isCorrect;
}

/*
{
	"username":"hans",
	"pwd":"pass1"
}

{
	"username":"Larcher",
	"token":"Schule22"
}
*/