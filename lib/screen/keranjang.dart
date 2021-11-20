import 'dart:convert';

import 'package:cubaapi/model_api/cart_model.dart';
import 'package:cubaapi/model_api/food_cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

class Keranjang extends StatefulWidget {
  const Keranjang({Key? key}) : super(key: key);

  @override
  _KeranjangState createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  //List<CartFood> cart = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getDataList();
  }

  getDataList() async {
    final response = await http.get(Env().getCartProduct());
    if (response.statusCode == 200) {
      setState(() {
        _loading = false;
      });
      Iterable it = jsonDecode(response.body);
      print(response.body);
      CartItem.cart = it.map((e) => CartFood.fromJson(e)).toList();
      return CartItem.cart;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: Text("My Cart"),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Center(
          child: ListView.builder(
              itemCount: CartItem.cart.length,
              itemBuilder: (context, index) {
                final cart = CartItem.cart[index];
                return Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Column(
                    children: [
                      Container(
                        height: 130,
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                              Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                width: 117,
                                height: 95,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(cart.image), fit: BoxFit.cover)
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                width: 117,
                                height: 100,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Align(
                                        child: Text(
                                          cart.name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                        ),
                                        alignment: Alignment.topLeft,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 84,
                                            height: 26,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.orange,
                                                    width: 2)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(left: 5),
                                                  child: Text(
                                                    "+",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.orange),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(left: 5),
                                                  child: Text(
                                                    cart.qty.toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: Text(
                                                    "-",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.orange),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            child: Text(
                                              cart.price.toString(),
                                              style: TextStyle(fontSize: 12),
                                              maxLines: 2,
                                            ),
                                            alignment: Alignment.centerRight,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        (cart.price * cart.qty).toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
Widget imageItem(//String site
    ) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(10),
      width: 117,
      height: 95,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
        // image: DecorationImage(
        //     image: NetworkImage(site), fit: BoxFit.cover)
      ),
    ),
  );
}

Widget itemContent(String name, String qty, String price) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
      width: 117,
      height: 100,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Align(
              child: Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              alignment: Alignment.topLeft,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 84,
                  height: 26,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.orange, width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "+",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          qty,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          "-",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  child: Text(
                    price,
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                  ),
                  alignment: Alignment.centerRight,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "30",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
          ),
        ],
      ),
    ),
  );
}
