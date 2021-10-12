import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {

  final String title;
  final String rate;
  final String thumb;
  final String person;

  const ListCard(
      {Key? key,
      required this.title,
      required this.rate,
      required this.thumb, required this.person})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(0.0, 10.0),
                blurRadius: 10.0,
                spreadRadius: -6.0)
          ],
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35), BlendMode.multiply),
              image: NetworkImage(thumb),
              fit: BoxFit.cover)),

      child: Stack(
        children: [
          Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 20,color: Colors.white, wordSpacing: 2),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.center,
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all (5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 10,),
                    SizedBox(width: 5,),
                    Text(rate,style: TextStyle(color: Colors.white))
                  ],
                ) ,
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all (10),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.yellow, size: 10,),
                    SizedBox(width: 5,),
                    Text(person,style: TextStyle(color: Colors.white),maxLines: 2,)
                  ],
                ),
              ),
            ],),
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
      );
  }
}
