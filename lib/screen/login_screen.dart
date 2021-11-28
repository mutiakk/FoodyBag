import 'dart:convert';

import 'package:cubaapi/model_api/model_user.dart';
import 'package:cubaapi/screen/home_screen.dart';
import 'package:cubaapi/screen/regist_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

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
        // List<User> userModel=(body['user']as Iterable).map((e) => User.fromJson(e)).toList();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("user", body['token']);
        Map<String, dynamic> user = {
          'id': body['user']["username"],
          'username': body['user']["username"],
          'password': body['user']["password"],
          'registered': body['user']["registered"],
          'login': body['user']["login"],
        };
        await prefs.setString("login", jsonEncode(user));
        await prefs.setString("user", body["token"]);
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
        resizeToAvoidBottomInset: false,
        body: Container(
            child: Center(
              child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Form(child: formSignIn()),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RegistPage()),
                                    );
                                  },
                                  child: Text(
                                    "Don't have an account? Register",
                                    style: TextStyle(color: Colors.black),
                                  ))
                            ],
                          ),
                        ),
                        // SizedBox(height: 20,),
                        // // Stack(
                        // //   children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(50,10,10,10),
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 50,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),

                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(100))),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        width: 35,
                        height: 35,
                        child: circle()),
                    Positioned(
                        bottom: 55,
                        right: 55,
                        width: 75,
                        height: 75,
                        child: circle()),
                    Positioned(
                        bottom: 125,
                        right: 125,
                        width: 100,
                        height: 100,
                        child: circle()),
                  ]),
              //formLogin(),
            )));
  }

  Widget formSignIn() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.text,
          controller: emailControl,
          decoration: InputDecoration(
            labelText: 'Name',
            icon: Icon(Icons.person),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.lightGreen, width: 2)),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: 'Password',
              icon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                child: Icon(
                  _passHide ? Icons.visibility_off : Icons.visibility,
                  color: _passHide ? Colors.grey : Colors.blueAccent,
                ),
                onTap: () {
                  _password();
                },
              )),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _login();
          },
          //color: Colors.orange,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Login',style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              )),
        ),
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


