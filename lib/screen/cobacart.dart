import 'package:flutter/material.dart';

class CobaCart extends StatefulWidget {
  Map<String?, dynamic> mantap;
  CobaCart({Key? key, required this.mantap}) ;

  @override
  _CobaCartState createState() => _CobaCartState();
}

class _CobaCartState extends State<CobaCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:Center(child: Column(children: [
        ListView.builder(itemBuilder: (context, i){
        return Text(widget.mantap['yuhu'].name);
      }),
      ]))));
  }
}
