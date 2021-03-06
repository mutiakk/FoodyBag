import 'dart:convert';

import 'package:cubaapi/screen/home_screen.dart';
import 'package:cubaapi/screen/login_screen.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model_api/api.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  _RegistPageState createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  bool _passHide = true;

  //controller
  final emailControl = TextEditingController();
  final passControl = TextEditingController();
  final passControl2 = TextEditingController();
  final fullName = TextEditingController();
  final address = TextEditingController();

  void _password() {
    setState(() {
      _passHide = !_passHide;
    });
  }

  void _validateRegister(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              elevation: 24,
              title: Text("is the data entered is correct?",
                  maxLines: 2,
                  style: ThemeFonts.textStyle600.copyWith(fontSize: 18),
                  textAlign: TextAlign.left),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Text(),
                  Align(child: Text(
                    "Please check again.",
                    style: ThemeFonts.textStyle200
                        .copyWith(fontSize: 12, color: ThemeColor.black),
                  ),alignment: Alignment.topLeft,)
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0xffE5E5E5)),
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text("Cancel", style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: ThemeColor.primOrange),
                    onPressed: () {
                      setState(() {
                        int count = 0;
                        Navigator.popUntil(context, (route) {
                          return count++ == 2;
                        });
                       _regist();
                      });
                    },
                    child: const Text('OK',
                        style: TextStyle(
                            fontFamily: "NunitoSans", color: Colors.white)))
              ],
            ));
  }

  void _regist() async {
    if (emailControl.text.isNotEmpty &&
        passControl.text.isNotEmpty &&
        passControl2.text.isNotEmpty) {
      var response = await http.post(Env().postRegistCustomer(),
          body: jsonEncode({
            "username": emailControl.text,
            "password": passControl.text,
            "password_repeat": passControl2.text,
            "fullname": fullName.text,
            "address": address.text
          }),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Register Success')));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("register", body['message']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      } else if (response.statusCode == 409) {
        final body = jsonDecode(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['msg'])));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('unsucces')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Blank Value')));
    }
    // }
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
                  bottomLeft: Radius.circular(100),
                ),
                color: ThemeColor.primOrange),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 40, 0, 0),
              child: Container(
                  //alignment: Alignment.bottomRight,
                  child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Register',
                  style: ThemeFonts.textStyle400,
                ),
              )),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                child: formRegister(),
              )),
        ]),
        Positioned(top: 10, left: 10, width: 35, height: 35, child: circle()),
        Positioned(top: 55, left: 55, width: 75, height: 75, child: circle()),
        Positioned(
            top: 125, left: 125, width: 100, height: 100, child: circle()),
      ]),
    )));
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

  Widget formRegister() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.text,
          controller: fullName,
          decoration: InputDecoration(
            labelText: 'Full Name',
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
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: emailControl,
          decoration: InputDecoration(
            labelText: 'Username',
            icon: Icon(Icons.alternate_email),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: ThemeColor.primOrange, width: 2)),
          ),
        ),
        SizedBox(
          height: 10,
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
        SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: passControl2,
          obscureText: _passHide,
          decoration: InputDecoration(
            labelText: 'Repeat Password',
            icon: Icon(Icons.lock),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: ThemeColor.primOrange, width: 2)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: address,
          decoration: InputDecoration(
            labelText: 'Address',
            icon: Icon(Icons.home_filled),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: ThemeColor.primOrange, width: 2)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          color: ThemeColor.primOrange,
          onPressed: () {
            _validateRegister(context);
          },
          child: Text(
            "Register",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
