import 'dart:convert';

import 'package:cubaapi/model_api/foodModel2.dart';
import 'package:cubaapi/model_api/food_calculate.dart';
import 'package:cubaapi/model_api/food_cart.dart';
import 'package:cubaapi/screen/cart_page.dart';
import 'package:cubaapi/screen/keranjang.dart';
import 'package:cubaapi/widget/CustomPageHero.dart';
import 'package:cubaapi/widget/desc_widget/appBarDesc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../api.dart';
import 'cobacart.dart';

class DescFood extends StatefulWidget {

  Map<String, dynamic> data;

  // final FoodModel data;

  DescFood({Key? key, required this.data});

//required this.data
  @override
  _DescFoodState createState() => _DescFoodState();
}

class _DescFoodState extends State<DescFood> {
  List<FoodModel> cartItems = [];
  late final FoodModel foods;
  late int selected = 0;

  @override
  void initState() {
    super.initState();
  }

  void counterPlus() {
    setState(() {
      selected++;
    });
  }

  void _buttonCart() async {
    print("start");
    if (selected != 0) {
      var response = await http.post(Env().postCartProduct(),
          body: jsonEncode({
            "idCart": widget.data['example'].id,
            "qty": widget.data['example'].qty
          }),
          headers: {"Content-Type": "application/json"});
      final body = jsonDecode(response.body);
      if (body["msg"] == "Item Updated") {
        print('sukses');
        print(body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body["msg"])));
      } else {
        print('gagal');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          // child: Consumer<Price>(
          //   builder: (context, count, child) {
          //     return
          child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width - 2 * 50,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // print (widget.data['example']);
                        _buttonCart();
                        setState(() {
                          selected = widget.data['example'].id;
                        });

                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                      ),
                      // color: Colors.orange,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.push(context, CustomHero(page: Keranjang()));
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.orange,
                      size: 45,
                    ))
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.data['example'].image),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(children: [
                Positioned(
                    top: 0,
                    left: 5,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(0, 5),
                                spreadRadius: 5,
                                color: Colors.orange.shade200)
                          ]),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    )),
              ]),
            ),
            Container(
              child: content(
                  widget.data['example'].name,
                  widget.data['example'].star.toString(),
                  widget.data['example'].image,
                  widget.data['example'].person.toString(),
                  widget.data['example'].desc,
                  widget.data['example'].price.toString(),
                  widget.data['example'].country),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ])),
        ));
  }
}

Widget content(String name, String star, String image, String person,
    String desc, String price, String country) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.all(15),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              maxLines: 2,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Rp. ' + price,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontSize: 25,
              ),
              maxLines: 2,
            ),
          )
        ]),
      ),
      Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.orange[300], borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'About the menu',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 3),
          ),
        ),
      ),
      Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: Colors.orange),
                  ),
                  child: Column(children: [
                    Row(children: <Widget>[
                      Icon(
                        Icons.flag,
                        color: Colors.orange,
                      ),
                      Text(
                        'Country',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.orange),
                      ),
                    ]),
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Text(
                          country,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ])),
            ],
          ),
          Column(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: Colors.orange),
                  ),
                  child: Column(children: [
                    Row(children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.orange,
                      ),
                      Text(
                        'Serving Person',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.orange),
                      ),
                    ]),
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Text(
                          person + " person",
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ])),
            ],
          ),
        ]),
      ),
      Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.orange[300], borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Description',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 3),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
        margin: EdgeInsets.all(5),
        child: Text(
          desc,
          style: TextStyle(
            wordSpacing: 4,
            fontSize: 16,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    ],
  );
}
