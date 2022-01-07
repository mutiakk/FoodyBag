import 'dart:async';

import 'package:cubaapi/screen/login_screen.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? user;

  @override
  void initState() {
    super.initState();
    getLogin().whenComplete(() async{Timer(Duration(seconds: 3),
            ()=> Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                (user?.isEmpty??true ? LoginPage():MyHome())
            )
        ));
    });
  }
  Future getLogin()async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? value = prefs.getString("login");
    String? loginPrefs=prefs.getString("user");
    setState(() {
      user= loginPrefs;
    });
    print (user);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 0, left: -50, width: 150, height: 150, child: circle()),
            Positioned(
                top: 100, right: 40, width: 80, height: 80, child: circle()),
            Positioned(
                bottom: -50,
                right: -10,
                width: 150,
                height: 150,
                child: circle()),
            Positioned(
                bottom: 100, left: 40, width: 80, height: 80, child: circle()),
            Positioned(
                bottom: 270, right: 60, width: 50, height: 50, child: circle()),
            Positioned(
                top: 200, left: 70, width: 50, height: 50, child: circle()),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.5,
                  bottom: 10,
                ),
                alignment: Alignment.center,
                child: centerObject(),
              ),
            ), //centerObject()),
          ],
        ),
      ),
    );
  }
}

Widget centerObject() {
  return Column(
    children: [
      Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          // color: Colors.yellow
            image: DecorationImage(
                image: AssetImage(
                  'asset/food.png',
                ),
                fit: BoxFit.cover)),
      ),
      Text(
        "FoodyBag",
        style: ThemeFonts.textStyle600
            .copyWith(fontSize: 30, color: ThemeColor.primOrange),
      ),
      Container(
          padding: EdgeInsets.only(top: 10),
          width: 50,
          height: 50,
          child: LoadingIndicator(
            indicatorType: Indicator.lineScale,
            colors: [Colors.orange, Colors.orangeAccent,Colors.deepOrange],
          )),
    ],
  );
}

Widget circle() {
  return Container(
      height: 50,
      width: 50,
      decoration: ShapeDecoration(
        color: ThemeColor.primOrange,
        shape: CircleBorder(),
      ));
}



