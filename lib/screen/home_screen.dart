import 'dart:io';

import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:cubaapi/widget/listFoodBackEnd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  DateTime? lastPressed;

  void _out(context, bool mantap) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          elevation: 24,
          title: Text("Do you want to quit?",
              maxLines: 2,
              style: ThemeFonts.textStyle600.copyWith(fontSize: 18),
              textAlign: TextAlign.left),

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
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else {
                      exit(0);
                    }
                  });
                },
                child: const Text('OK',
                    style: TextStyle(
                        fontFamily: "NunitoSans", color: Colors.white)))
          ],
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child:ListProduct()
              ),
            ],
          ),
        ),onWillPop:() async {
          final now = DateTime.now();
          final maxDuration = Duration(seconds: 2);
          final isWarning = lastPressed == null ||
              now.difference(lastPressed!) > maxDuration;

          if (isWarning) {
            lastPressed = DateTime.now();

            final snackBar = SnackBar(
              content: Text('Double Tap To Close App'),
              duration: maxDuration,
            );

            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(snackBar);

            return false;
          } else {
            _out(context, true);
            return true;
          }
        },));
  }
}
