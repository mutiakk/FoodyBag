import 'dart:convert';

import 'package:cubaapi/screen/home_screen.dart';
import 'package:cubaapi/screen/regist_screen.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model_api/api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passHide = true;

  //controller
  final emailControl = TextEditingController();
  final passControl = TextEditingController();

  @override
  void initState() {
    //checkLogin();
    super.initState();
  }

  //hiding pass
  void _password() {
    setState(() {
      _passHide = !_passHide;
    });
  }

  //login
  void _login() async {
    if (emailControl.text.isNotEmpty && passControl.text.isNotEmpty) {
      var response = await http.post(Env().postLoginCustomer(),
          body: jsonEncode({
            "username": emailControl.text,
            "password": passControl.text,
          }),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print("login token " + body["msg"]);
        print(body["user"]["fullname"]);
        print(body["user"]["username"]);
        // List<User> userModel=(body['user']as Iterable).map((e) => User.fromJson(e)).toList();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("user", body['token']);
        await prefs.setString ("name", body ['user']['fullname']);
        await prefs.setString ("username", body ['user']['username']);
        await prefs.setString("user", body["user"]["id"]);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body["msg"])));
        //awaitW prefs.setStringList("login", body['user'].toJson());

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyHome()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonDecode(response.body)["msg"])));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Blank Value')));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Stack(children: [
        Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100),
                ),
                color: ThemeColor.primOrange),
                   alignment: Alignment.bottomLeft,
                  child: Padding(padding: EdgeInsets.only(top: 10),
                  child:Text(
                      'Login',
                      style: ThemeFonts.textStyle400,
                    ),
                  ), ),

          Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                child: formSignIn(),
                //formSignIn(),
              )),
        ]),
        Positioned(top: 10, right: 10, width: 35, height: 35, child: circle()),
        Positioned(top: 55, right: 55, width: 75, height: 75, child: circle()),
        Positioned(
            top: 125, right: 125, width: 100, height: 100, child: circle()),
      ]),
    )));
  }

  Widget formSignIn() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.text,
          controller: emailControl,
          decoration: InputDecoration(
            labelText: 'Username',
            icon: Icon(Icons.person),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: ThemeColor.primOrange, width: 2)),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: _passHide,
          controller: passControl,
          decoration: InputDecoration(
              labelText: 'Password',
              icon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                child: Icon(
                  _passHide ? Icons.visibility_off : Icons.visibility,
                  color: _passHide ? Colors.grey : ThemeColor.primOrange,
                ),
                onTap: () {
                  _password();
                },
              ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: ThemeColor.primOrange, width: 2)),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style:
              ElevatedButton.styleFrom(primary: ThemeColor.primOrange),
          onPressed: () {
            _login();
          },
          //color: ThemeColor.primOrange,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              )),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistPage()),
              );
            },
            child: Text("Don't have an accout? Register!",
                style: TextStyle(color: ThemeColor.primOrange)))
      ],
    );
  }

  Widget circle() {
    return Container(
        height: 50,
        width: 50,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: CircleBorder(),
        ));
  }
}
