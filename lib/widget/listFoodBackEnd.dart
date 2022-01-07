import 'dart:convert';
import 'package:cubaapi/model_api/food_model.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:cubaapi/widget/CustomPageHero.dart';
import 'package:cubaapi/widget/home_widget/appBar.dart';
import 'package:cubaapi/widget/home_widget/sideBar.dart';
import 'package:cubaapi/widget/home_widget/wid_hello.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';

import '../model_api/api.dart';
import '../screen/desc_food.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  bool _loading = true;
  var foody = <FoodModel>[];

  @override
  void initState() {
    super.initState();
    getDataList();
  }

  Future getDataList() async {
    final response = await http.get(Env().getListProduct());
    if (response.statusCode == 200) {
      setState(() {
        _loading = false;
        Iterable it = jsonDecode(response.body);
        print(response.body);
        foody = it.map((e) => FoodModel.fromJson(e)).toList();
      });
      return foody;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideBarApp(),
        body:
            _loading
                ? Center(
                    child: Container(
                        padding: EdgeInsets.only(top: 10),
                        width: 50,
                        height: 50,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineScale,
                          colors: [ThemeColor.orange, Colors.orangeAccent,Colors.deepOrange],
                        )),)
            : Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: ListView.builder(
                    itemBuilder: (context, i) {
                      if (i == 0) {
                        return Container(
                          height: 270,
                          decoration: BoxDecoration(
                              color: ThemeColor.primOrange,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          child: Column(
                            children: [
                              AppBarHome(),
                              HelloWidget(),
                            ],
                          ),
                        );
                      }
                      int numberOfExtraWidget =
                          1; // here we have 1 ExtraWidget i.e Container.
                      i = i - numberOfExtraWidget;
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
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 8,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: imageFood(foody[i].name,
                              foody[i].price.toString(), foody[i].image),
                        ),
                      );
                    },
                    itemCount: foody.length + 1)));
  }

  Widget imageFood(String name, String price, String image) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child:Container(
              decoration: BoxDecoration(
                //border: Border.all(width: 2, color: Colors.deepOrange),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
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
                    child: Container(
                      width: 100,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      name,
                      maxLines: 2,
                      style: ThemeFonts.textStyle500,
                    ),
                    subtitle: Text(
                      'Rp.' + price,
                      textAlign: TextAlign.right,
                      style: ThemeFonts.textStyle200,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
