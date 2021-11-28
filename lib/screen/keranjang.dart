import 'dart:convert';

import 'package:cubaapi/model_api/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

class Keranjang extends StatefulWidget {


  Keranjang({Key? key});

  @override
  _KeranjangState createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  //late int qty,id;
  bool _loading = true;
  var cart = <CartFood>[];
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
        selected = 0;
      }
    });
  }

  void _buttonCartPlus(int idOrder, int qty) async {
    print("plus");
    if (selected != 0) {
      var response = await http.post(Env().plusCart(),
          body: jsonEncode({"idCart": idOrder, "qty": qty}),
          headers: {"Content-Type": "application/json"});
      final body = jsonDecode(response.body);
      print(idOrder);
      if (body["msg"] == "Item Updated") {
        print(body["msg"]);
        getDataList();
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
    if (selected != 0) {
      var response = await http.post(Env().minCart(),
          body: jsonEncode({"idCart": idCart, "qty": qty}),
          headers: {"Content-Type": "application/json"});
      final body = jsonDecode(response.body);
      print(idOrder);
      if (body["msg"] == "Item Updated") {
        print(body["msg"]);
        //_buttonCartMin(idCart, qty, id);
        getDataList();
        print(body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body["msg"])));
      } else {
        print('gagal');
      }
    } else if (selected == 0) {
      counterMinus();
      delDataList(idOrder.toString());
    }
  }

  Future getDataList() async {
    final response = await http.get(Env().getCartProduct());
    cart.clear();
    if (response.statusCode == 200) {
      print('sukses');
      setState(() {
        _loading = false;
        Iterable it = jsonDecode(response.body);
        print(response.body);
        cart = it.map((e) => CartFood.fromJson(e)).toList();
      });
      return cart;
    }
  }

  void delDataList(idOrder) async {
    print('start del');
    final response = await http.delete(Env().delCart(idOrder));
        // body: jsonEncode({"idCart": idCart, "qty": qty}),
        //headers: {"Content-Type": "application/json"});
    //final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('sukses');
      setState(() {
        _loading = false;
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
        backgroundColor: Colors.orange,
        title: Text("My Cart"),
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
              "Total",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.blueGrey),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 10),
            child: Text(
              cartTotalPrice().toString(),
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          MaterialButton(
            onPressed: () {},
            color: Colors.black,
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
                        height: 145,
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
                                height: 95,
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
                                                        cart[index].id,
                                                        cart[index].qty);
                                                    counterPlus();
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
                                                  left: 5, right: 5),
                                              child: Text(
                                                  cart[index].qty.toString()),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(20, 20),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _buttonCartMin(
                                                        cart[index].idCart,
                                                        cart[index].qty--,
                                                        cart[index].id, cart[index].idOrder);
                                                    counterMinus();
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
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              delDataList(cart[index].idOrder.toString());
                                                print("del");
                                            },
                                            icon: Icon(Icons
                                                .restore_from_trash_rounded)),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            prices(cart[index].price,
                                                    cart[index].qty)
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange),
                                          ),
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
