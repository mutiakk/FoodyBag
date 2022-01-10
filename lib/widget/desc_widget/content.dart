import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentDesc extends StatelessWidget {
  final String title;
  final String rate;
  final String thumb;
  final String person;
  final String desc;
  final String price;

  const ContentDesc(
      {Key? key,
      required this.title,
      required this.rate,
      required this.thumb,
      required this.person,
      required this.desc,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(thumb), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20)),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'About the menu',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 3),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(158),
                1: FlexColumnWidth(),
              },
              children: [
                TableRow(children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Icon(Icons.flag),
                        Text(
                          'Country',
                          maxLines: 2,
                        )
                      ])),
                  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      child: Text(rate, maxLines: 2)),
                ]),
                TableRow(children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Icon(Icons.person),
                        Text(
                          'Serving Person',
                          maxLines: 2,
                        )
                      ])),
                  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      child: Text(
                        person,
                        maxLines: 2,
                      )),
                ]),
                TableRow(children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Icon(Icons.money),
                        Text(
                          'Price',
                          maxLines: 2,
                        )
                      ])),
                  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      child: Text(
                        price,
                        maxLines: 2,
                      )),
                ])
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Description',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 3),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
            margin: EdgeInsets.all(5),
            child: Text(
              desc,
              style: TextStyle(
                wordSpacing: 4,
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
