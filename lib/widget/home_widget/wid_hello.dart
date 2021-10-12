import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelloWidget extends StatelessWidget {
  const HelloWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Stack(
        children: [
          Align(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only (top:10),
                  margin: EdgeInsets.all(5),
                  child: Text('HALLO FOODY! ',style: TextStyle(fontSize: 20, letterSpacing: 10,fontWeight: FontWeight.bold,color: Colors.blueGrey),textAlign: TextAlign.left),
                ),
                Container(
                  padding: EdgeInsets.only (left: 15,top: 10),
                  margin: EdgeInsets.all(2),
                  child: Text('Mau masak apa hari ini?',style: TextStyle(fontSize: 15,color: Colors.blueGrey),),
                )
              ],
            ),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }
}
