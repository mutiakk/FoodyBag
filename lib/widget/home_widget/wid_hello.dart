import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelloWidget extends StatelessWidget {
  const HelloWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
          ),
      child: Stack(
        children: [

          Align(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('HALLO FOODY! ',
                            style: TextStyle(
                                fontSize: 30,
                                letterSpacing: 5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.left),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Mau masak apa hari ini?',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[65]),
                            textAlign: TextAlign.left
                        ),
                      )
                    ])),
              ],
            ),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }
}
