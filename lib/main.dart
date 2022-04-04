import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/loginScreen.dart';

late SharedPreferences sharedPreferences;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/config/.env");
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  static const String _title = 'Login';
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Trip',
      theme: ThemeData.dark().copyWith(

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff2F8D46), //0xff2196F3
        ),

        primaryColor: const Color(0xff2F8D46),
        splashColor: Colors.transparent,
      ),
      home:  Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyLoginWidget(),
      ),
    );
  }
}
