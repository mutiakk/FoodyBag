import 'dart:async';

import 'package:cubaapi/screen/receipt_widget_payment.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String payment = "";

  @override
  void initState() {
    getPaymentShared();
    Timer(
        Duration(seconds: 8),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PaymentIdScreen())));
    super.initState();
  }

  void getPaymentShared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      payment = pref.getString("yuhuMantap")!;
    });
    print(payment);
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

  Widget centerObject() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          child: Icon(
            Icons.check_circle_outline,
            color: ThemeColor.orange,
            size: 100,
          ),
        ),
        Text(
          "Thank You For Order!!",
          style: ThemeFonts.textStyle600
              .copyWith(fontSize: 30, color: ThemeColor.primOrange),
        ),
        Container(
            padding: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    payment,
                    style: ThemeFonts.textStyle600,
                  ),
                ],
              ),
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
}
