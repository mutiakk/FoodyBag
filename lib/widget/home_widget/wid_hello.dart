import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelloWidget extends StatelessWidget {
  const HelloWidget({Key? key}) : super(key: key);

  static final List<String> images = [
    'asset/app1.png',
    'asset/app2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
      ),
      child: Stack(children: [
        Positioned(
          top: 0,
          left: 10,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('HALLO FOODY! ',
                style: ThemeFonts.textStyle600.copyWith(
                    fontSize: 30, color: ThemeColor.white, letterSpacing: 3),
                textAlign: TextAlign.left),
          ),
        ),
        Positioned(
          top: 30,
          left: 10,
          child: Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Text('Mau Makan Apa Hari Ini??',
                style: ThemeFonts.textStyle300
                    .copyWith(fontSize: 20, color: ThemeColor.white),
                textAlign: TextAlign.left),
          ),
        ),
        Positioned(
          top: 100,
          left: 10,
          child: Container(
            height: 100,
            width:MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Stack(
                  // Membuat lapisan
                  children: [
                    Container(
                      width: 250,
                      height: 75,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

        )]),
    );
  }
}
