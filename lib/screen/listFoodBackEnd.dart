import 'dart:convert';

import 'package:cubaapi/model_api/foodModel2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cubaapi/widget/CustomPageHero.dart';
import 'package:cubaapi/widget/home_widget/appBar.dart';
import 'package:cubaapi/widget/home_widget/sideBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';

import '../api.dart';
import 'desc_food.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  bool _loading = true;
  var foody= <FoodModel>[];
  @override
  void initState() {
    super.initState();
    getDataList();
  }

  // getData() async {
  //   foody = await getDataList();
  //   setState(() {});
  // }

  Future getDataList() async {
      final response = await http.get(Env().getListProduct());
      if (response.statusCode == 200) {
        setState(() {
          _loading = false;
          Iterable it = jsonDecode(response.body);
          print(response.body);
          foody = it.map((e) => FoodModel.fromJson(e)).toList();
        });
        // List<FoodModel> food = it.map((e) => FoodModel.fromJson(e)).toList();
        return foody;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading
            ? Center(
                child: Container(
                    padding: EdgeInsets.only(top: 10),
                    width: 50,
                    height: 50,
                    child: LoadingIndicator(
                      indicatorType: Indicator.lineScale,
                      colors: [Colors.orange, Colors.orangeAccent,Colors.deepOrange],
                    )),)
            : Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: ListView.separated(
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CustomHero(
                                  page: DescFood(
                                    data: {'example': foody[i]},
                              )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 8,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: imageFood(foody[i].name,
                              foody[i].price.toString(), foody[i].image),
                        ),
                      );
                    },
                    separatorBuilder: (context, i) {
                      return Divider();
                    },
                    itemCount: foody.length)));
  }
}

Widget imageFood(String name, String price, String image) {
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          //border: Border.all(width: 2, color: Colors.deepOrange),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // add this
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(image, height: 200, fit: BoxFit.fitWidth),
            ),
            ListTile(
              title: Text(
                name,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Rp.' + price,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
      ));
}

