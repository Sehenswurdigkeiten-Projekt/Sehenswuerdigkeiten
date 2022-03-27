
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:untitled/loginScreen.dart';
import 'package:untitled/mainstrukturwebseite.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

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
    return Container(
        color: Color(0xFF424242),//color: Color(0xFF424242),0xFFE0E0E0
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'One Trip',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              child: Column(children: <Widget>[
                Container(
                  width: 150,
                  margin: EdgeInsets.all(10),
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
                  'Sign Up',
                  style: TextStyle(fontSize: 22),
                )),
            Container( //https://medium.com/flutter-community/a-visual-guide-to-input-decorations-for-flutter-textfield-706cf1877e25
              padding: const EdgeInsets.all(10),
              child: TextField(
                autofocus: false,
                controller: nameController,
                cursorColor: const Color(0xff9a9a9a),
                maxLength: 20,

                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[A-Za-zÀÁÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÆÐƎƏƐƔĲŊŒẞÞǷȜæðǝəɛɣĳŋœĸſßþƿȝĄƁÇĐƊĘĦĮƘŁØƠŞȘŢȚŦŲƯY̨Ƴąɓçđɗęħįƙłøơşșţțŧųưy̨ƴÁÀÂÄǍĂĀÃÅǺĄÆǼǢƁĆĊĈČÇĎḌĐƊÐÉÈĖÊËĚĔĒĘẸƎƏƐĠĜǦĞĢƔáàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣĤḤĦIÍÌİÎÏǏĬĪĨĮỊĲĴĶƘĹĻŁĽĿʼNŃN̈ŇÑŅŊÓÒÔÖǑŎŌÕŐỌØǾƠŒĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœŔŘŖŚŜŠŞȘṢẞŤŢṬŦÞÚÙÛÜǓŬŪŨŰŮŲỤƯẂẀŴẄǷÝỲŶŸȲỸƳŹŻŽẒŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ0-9_.-]')),
                  //FilteringTextInputFormatter.allow(RegExp('[A-Za-zÀÁÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÆÐƎƏƐƔĲŊŒẞÞǷȜæðǝəɛɣĳŋœĸſßþƿȝĄƁÇĐƊĘĦĮƘŁØƠŞȘŢȚŦŲƯY̨Ƴąɓçđɗęħįƙłøơşșţțŧųưy̨ƴÁÀÂÄǍĂĀÃÅǺĄÆǼǢƁĆĊĈČÇĎḌĐƊÐÉÈĖÊËĚĔĒĘẸƎƏƐĠĜǦĞĢƔáàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣĤḤĦIÍÌİÎÏǏĬĪĨĮỊĲĴĶƘĹĻŁĽĿʼNŃN̈ŇÑŅŊÓÒÔÖǑŎŌÕŐỌØǾƠŒĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœŔŘŖŚŜŠŞȘṢẞŤŢṬŦÞÚÙÛÜǓŬŪŨŰŮŲỤƯẂẀŴẄǷÝỲŶŸȲỸƳŹŻŽẒŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ0-9_.-]')),
                ],

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

                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[A-Za-zÀÁÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÆÐƎƏƐƔĲŊŒẞÞǷȜæðǝəɛɣĳŋœĸſßþƿȝĄƁÇĐƊĘĦĮƘŁØƠŞȘŢȚŦŲƯY̨Ƴąɓçđɗęħįƙłøơşșţțŧųưy̨ƴÁÀÂÄǍĂĀÃÅǺĄÆǼǢƁĆĊĈČÇĎḌĐƊÐÉÈĖÊËĚĔĒĘẸƎƏƐĠĜǦĞĢƔáàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣĤḤĦIÍÌİÎÏǏĬĪĨĮỊĲĴĶƘĹĻŁĽĿʼNŃN̈ŇÑŅŊÓÒÔÖǑŎŌÕŐỌØǾƠŒĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœŔŘŖŚŜŠŞȘṢẞŤŢṬŦÞÚÙÛÜǓŬŪŨŰŮŲỤƯẂẀŴẄǷÝỲŶŸȲỸƳŹŻŽẒŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ0-9\$!#%&'*+,-./:;<=>?@^_`|~]")),
                  //FilteringTextInputFormatter.allow(RegExp("[A-Za-zÀÁÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÆÐƎƏƐƔĲŊŒẞÞǷȜæðǝəɛɣĳŋœĸſßþƿȝĄƁÇĐƊĘĦĮƘŁØƠŞȘŢȚŦŲƯY̨Ƴąɓçđɗęħįƙłøơşșţțŧųưy̨ƴÁÀÂÄǍĂĀÃÅǺĄÆǼǢƁĆĊĈČÇĎḌĐƊÐÉÈĖÊËĚĔĒĘẸƎƏƐĠĜǦĞĢƔáàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣĤḤĦIÍÌİÎÏǏĬĪĨĮỊĲĴĶƘĹĻŁĽĿʼNŃN̈ŇÑŅŊÓÒÔÖǑŎŌÕŐỌØǾƠŒĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœŔŘŖŚŜŠŞȘṢẞŤŢṬŦÞÚÙÛÜǓŬŪŨŰŮŲỤƯẂẀŴẄǷÝỲŶŸȲỸƳŹŻŽẒŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ0-9\$!#%&'*+,-./:;<=>?@^_`|~]")),
                ],

                controller: passwordController,
                decoration: const InputDecoration(
                  counterText: "",
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                autofocus: false,
                obscureText: true,
                cursorColor: const Color(0xff9a9a9a),
                maxLength: 20,

                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[A-Za-zÀÁÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÆÐƎƏƐƔĲŊŒẞÞǷȜæðǝəɛɣĳŋœĸſßþƿȝĄƁÇĐƊĘĦĮƘŁØƠŞȘŢȚŦŲƯY̨Ƴąɓçđɗęħįƙłøơşșţțŧųưy̨ƴÁÀÂÄǍĂĀÃÅǺĄÆǼǢƁĆĊĈČÇĎḌĐƊÐÉÈĖÊËĚĔĒĘẸƎƏƐĠĜǦĞĢƔáàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣĤḤĦIÍÌİÎÏǏĬĪĨĮỊĲĴĶƘĹĻŁĽĿʼNŃN̈ŇÑŅŊÓÒÔÖǑŎŌÕŐỌØǾƠŒĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœŔŘŖŚŜŠŞȘṢẞŤŢṬŦÞÚÙÛÜǓŬŪŨŰŮŲỤƯẂẀŴẄǷÝỲŶŸȲỸƳŹŻŽẒŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ0-9\$!#%&'*+,-./:;<=>?@^_`|~]")),
                ],

                controller: confirmPasswordController,
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
                  labelText: 'Confirm Password',
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
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2F8D46)),
                  ),
                  child: const Text('Sign Up'),
                  onPressed: () async{
                    bool isCorrect = await checkIfCorrect(nameController.text, passwordController.text, confirmPasswordController.text);
                    print("BIIIIIITTTTTEEEE: $isCorrect");
                    if(isCorrect == false) {
                      Alert(
                        type: AlertType.warning,
                        context: context,
                        title: "Something is wrong!",
                        desc: "Please correct it!",
                      ).show();
                    }
                    else{
                      String jsonString = '{"username":"${nameController.text}","pwd":"${passwordController.text}"}';

                      print(jsonString); // Dart

                      nameController.text = "";
                      passwordController.text = "";
                      confirmPasswordController.text = "";
                      _navigateToMap(context);
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
                    style: TextStyle(fontSize: 20, color: Color(0xff2F8D46)),
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
    Navigator.pop(context);
  }
  void _navigateToMap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
  }
}
class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: MyLoginWidget()
    );
  }
}

Future<bool> checkIfCorrect (String name, String pass, String confPass) async {
  bool isCorrect = false;

  print("Name: $name, Pass: $pass, ConfPass: $pass");
  if(pass == confPass && name != "" && pass != "") {
    var resArray = await requestServer(name, pass);
    Object token = resArray[0];
    Object statusCode = resArray[1].toString();

    if(statusCode != "400"){
      isCorrect = true;
    }
  }
  print(isCorrect);
  return isCorrect;
}

Future<List<Object>> requestServer(String name, String pass) async{
  var body = {
    "username":name,
    "pwd":pass
  };

  var address = "http://185.5.199.33:30000";

  var client = new http.Client();
  var uri = Uri.parse("$address/create_account");
  http.Response res = await client.post(uri, body: body);

  var resArray = [res.body, res.statusCode];

  print("RESARRAY: $resArray");

  return resArray;
}