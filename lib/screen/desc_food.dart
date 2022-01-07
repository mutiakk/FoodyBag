import 'dart:convert';

import 'package:cubaapi/model_api/food_model.dart';
import 'package:cubaapi/screen/cart_screen.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:cubaapi/widget/CustomPageHero.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model_api/api.dart';

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

  void _buttonCart(int id, int qty) async {
    print("start");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String idUser = pref.getString("user")!;
    print(idUser);
    if (selected != 0) {
      var response = await http.post(Env().postCartProduct(),
          body: jsonEncode({
            "idCart": id,
            "qty": qty,
            "user": idUser,
          }),
          headers: {"Content-Type": "application/json"});
      final body = jsonDecode(response.body);
      if (body["msg"] == "Item Added") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body["msg"])));
      } else if (body["msg"] == "Item Updated") {
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

                        setState(() {
                          _buttonCart(widget.data['example'].id,
                              widget.data['example'].qty);
                          selected = widget.data['example'].id;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ThemeColor.primOrange,
                      ),
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
                      color: ThemeColor.primOrange,
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
                          color: ThemeColor.primOrange,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(0, 5),
                                spreadRadius: 5,
                                color: ThemeColor.primOrange)
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
              child: Text(name,
                  style: ThemeFonts.textStyle500.copyWith(
                    fontSize: 40,
                  ),
                  maxLines: 2),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Rp. ' + price,
                style: ThemeFonts.textStyle200,
                maxLines: 2,
              ),
            )
          ]),
        ),
        Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeColor.primOrange),
                    margin: EdgeInsets.all(5),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.flag,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'Country',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          country,
                          maxLines: 2,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeColor.primOrange),
                    margin: EdgeInsets.all(5),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'Person',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          person,
                          maxLines: 2,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeColor.primOrange),
                    margin: EdgeInsets.all(5),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'Rate',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          star,
                          maxLines: 2,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
                  )),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Description',
                style: TextStyle(
                    color: ThemeColor.primOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 3),
              ),
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
}
