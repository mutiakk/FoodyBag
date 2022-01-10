import 'dart:convert';

import 'package:cubaapi/model_api/cart_model.dart';
import 'package:cubaapi/screen/checkout_screen.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model_api/api.dart';

class Keranjang extends StatefulWidget {
  Keranjang({Key? key});

  @override
  _KeranjangState createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  List<CartFood> cart = [];
  int selected = 0;

  int? prices(int price, int qty) {
    return price * qty;
  }

  int cartTotalPrice() {
    int total = 0;
    cart.forEach((item) {
      total += item.price * item.qty;
    });
    return total;
  }

  @override
  void initState() {
    super.initState();
    getDataList();
    //delDataList(id);
  }

  void counterPlus() {
    setState(() {
      selected++;
    });
  }

  void counterMinus() {
    setState(() {
      if (selected > 0) {
        selected--;
      } else {
        selected = 1;
      }
    });
  }

  void _buttonCartPlus(int idCart, int qty) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String idUser = pref.getString("user")!;
    print(idUser);
    print("plus");
    if (selected != 0) {
      var response = await http.post(Env().plusCart(),
          body: jsonEncode({
            "idCart": idCart,
            "qty": qty,
            "user": idUser,
          }),
          headers: {"Content-Type": "application/json"});
      final body = jsonDecode(response.body);
      print(idCart);
      if (body["msg"] == "Item Updated") {
        print(body["msg"]);
        getDataList();
        counterPlus();
        print(body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body["msg"])));
      } else {
        print('gagal');
      }
    }
  }

  void _buttonCartMin(int id, int qty, int idCart, int idOrder) async {
    print("Minus");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String idUser = pref.getString("user")!;
    print(idUser);
    if (selected != 0) {
      print("Minus ke 1");
      var response = await http.post(Env().minCart(),
          body: jsonEncode({"idCart": idCart, "qty": qty, "user": idUser}),
          headers: {"Content-Type": "application/json"});
      final body = jsonDecode(response.body);
      print(idOrder);
      if (body["msg"] == "Item Updated") {
        print(body["msg"]);
        //_buttonCartMin(idCart, qty, id);
        getDataList();
        counterMinus();
        print(body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body["msg"])));
      } else {
        print('gagal');
      }
    }
    // else  {
    //   delDataList(idOrder.toString());
    //   getDataList();
    // }
  }

  Future getDataList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String idUser = pref.getString("user")!;
    print(idUser);
    final response = await http.get(Env().getCartProduct(idUser));
    cart.clear();
    if (response.statusCode == 200) {
      print('sukses');
      setState(() {
        //_loading = false;
        Iterable it = jsonDecode(response.body);
        print(response.body);
        cart = it.map((e) => CartFood.fromJson(e)).toList();
      });
      return cart;
    }
  }

  void delDataList(idOrder) async {
    print('start del');
    final response = await http.delete(Env().delCart(idOrder.toString()));
    if (response.statusCode == 200) {
      print('sukses');
      setState(() {
        //_loading = false;
        getDataList();
      });
      //return cart;
    } else {
      print("fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeColor.primOrange,
        title: Text("My Cart", style: ThemeFonts.textStyle500.copyWith(color: ThemeColor.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Rp " + cartTotalPrice().toString(),
              style: ThemeFonts.tPrice.copyWith(
                  letterSpacing: 1, color: ThemeColor.primOrange, fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MaterialButton(
              height: 30,
              minWidth: 30,
              child: Text("Checkout",
                  style: ThemeFonts.textStyle200
                      .copyWith(fontSize: 18, color: ThemeColor.white)),
              onPressed: () {
                if (cartTotalPrice() != 0) {
                  _validateCartToCO(context);
                } else {
                  _validateCart(context);
                }
              },
              color: ThemeColor.primOrange,
            ),
          )
        ],
      )),
      body: Center(
          child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                //int? price = cart[index].price * cart[index].qty;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        width: MediaQuery.of(context).size.width,
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
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(cart[index].image),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                width: 117,
                                height: 135,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Align(
                                        child: Text(
                                          cart[index].name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                        ),
                                        alignment: Alignment.topLeft,
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(20, 20),
                                                ),
                                                onPressed: () {
                                                  // print (widget.data['example']);
                                                  //_buttonCart();
                                                  setState(() {
                                                    _buttonCartPlus(
                                                        cart[index].idCart,
                                                        cart[index].qty++);
                                                    selected = cart[index].qty;
                                                    // counterPlus();
                                                  });
                                                },
                                                child: Text(
                                                  '+',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 2, right: 2),
                                              child: Text(
                                                  cart[index].qty.toString()),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(20, 20),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    if (cart[index].qty == 1) {
                                                      delDataList(
                                                          cart[index].idOrder);
                                                    } else if (cart[index]
                                                            .qty !=
                                                        0) {
                                                      _buttonCartMin(
                                                          cart[index].idCart,
                                                          cart[index].qty--,
                                                          cart[index].id,
                                                          cart[index].idOrder);
                                                      counterMinus();
                                                    } else {
                                                      print("Failed");
                                                    }
                                                    // counterMinus();
                                                  });
                                                },
                                                child: Text(
                                                  '-',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ]),
                                          Align(
                                            child: Text(
                                              "Rp " +
                                                  cart[index].price.toString(),
                                              style: TextStyle(fontSize: 12),
                                              maxLines: 2,
                                            ),
                                            alignment: Alignment.centerRight,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              delDataList(cart[index]
                                                  .idOrder
                                                  .toString());
                                              print("del");
                                            },
                                            icon: Icon(Icons
                                                .restore_from_trash_rounded,color: ThemeColor.orange,)),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                              "Rp " +
                                                  prices(cart[index].price,
                                                          cart[index].qty)
                                                      .toString(),
                                              style: ThemeFonts.textStyle500
                                                  .copyWith(fontSize: 18)),
                                        ),
                                      ],
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

  void _validateCart(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              elevation: 24,
              title: Row(
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: ThemeColor.primOrange,
                    size: 25,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Your Cart is Empty!",
                      textAlign: TextAlign.center,
                      style: ThemeFonts.textStyle600),
                ],
              ),
              actions: <Widget>[
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: ThemeColor.primOrange),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK',
                        style: TextStyle(
                            fontFamily: "NunitoSans", color: Colors.white)))
              ],
            ));
  }

  void _validateCartToCO(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          elevation: 24,
          title: Text(
              "Are you sure to checkout your item in the cart?",
              maxLines: 2,
              style: ThemeFonts.textStyle600.copyWith(fontSize: 18),
              textAlign: TextAlign.left),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Text(),
              Text(
                "Please check your item. Clik OK if you want to continue." ,
                style: ThemeFonts.textStyle200
                    .copyWith(fontSize: 12, color: ThemeColor.black),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style:
              TextButton.styleFrom(backgroundColor: Color(0xffE5E5E5)),
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text("Cancel", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: ThemeColor.primOrange),
                onPressed: () {
                  setState(() {
                    if (cartTotalPrice() != 0) {
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutScreen()));
                    }
                  });
                },
                child: const Text('OK',
                    style: TextStyle(
                        fontFamily: "NunitoSans", color: Colors.white)))
          ],
        ));
  }
}
