import 'dart:convert';

import 'package:cubaapi/model_api/api.dart';
import 'package:cubaapi/model_api/cart_model.dart';
import 'package:cubaapi/model_api/item.dart';
import 'package:cubaapi/screen/payment_screen.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<CartFood> cart = [];
  Item? selectedUser;

  List<Item> itemVa = Item.users();
  List<DropdownMenuItem<Item>>? _dropdownMenuItems;

  List category = [];
  String setId = "";
  String? holder;
  String method="";
  String getId = "";

  String getRandString() {
    var random = Random.secure();
    int len = 5;
    var values = List<int>.generate(len, (i) => random.nextInt(25));
    return base64UrlEncode(values);
  }

  void settingId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("idPayment", getRandString());
    print(getRandString());
  }

  void getingId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    getId = pref.getString("idPayment")!;
    print(getId);
  }

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

  int cartId() {
    int id = 0;
    cart.forEach((item) {
      id = item.idOrder;
      print(id);
    });
    return id;
  }

  void getDropDownItem() {
    setState(() {
      holder = selectedUser!.name;
    });
    print(holder);
  }

  void getTutor() {
    setState(() {
      method = selectedUser!.method;
    });
    print(method);
  }

  List<DropdownMenuItem<Item>> buildDropdownMenuItems(List itemvA) {
    List<DropdownMenuItem<Item>> items = [];
    for (Item va in itemvA) {
      items.add(
        DropdownMenuItem(
          value: va,
          child: Text(va.name,style: ThemeFonts.textStyle300.copyWith(fontSize: 14,color: ThemeColor.orange)),
        ),
      );
    }
    return items;
  }


  @override
  void initState() {
    super.initState();
    getDataList();
    getPayment();
    postPayment();
    settingId();
    getingId();
    _dropdownMenuItems = buildDropdownMenuItems(itemVa);
    selectedUser = _dropdownMenuItems![0].value;
    super.initState();
  }

  void validatePayment(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              elevation: 24,
              title: Text(
                  "Are you sure to pay " +
                      cartTotalPrice().toString() +
                      " via " +
                      holder!,
                  maxLines: 2,
                  style: ThemeFonts.textStyle600.copyWith(fontSize: 18),
                  textAlign: TextAlign.left),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Text(),
                  Text(
                    selectedUser!.method +" and Add notes with your Payment ID." ,
                    style: ThemeFonts.textStyle200
                        .copyWith(fontSize: 12, color: ThemeColor.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "your ID is ",
                        style: ThemeFonts.textStyle200
                            .copyWith(fontSize: 12, color: ThemeColor.black),
                      ),
                      Text(
                        getId,
                        style: ThemeFonts.textStyle200.copyWith(
                            fontSize: 12,
                            color: ThemeColor.orange,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
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
                        if (cartTotalPrice() == null) {
                          return null;
                        } else {
                          setState(() {
                            postPayment();
                            postHistory();
                          });
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => PaymentScreen()),
                          );
                        }
                      });
                    },
                    child: const Text('OK',
                        style: TextStyle(
                            fontFamily: "NunitoSans", color: Colors.white)))
              ],
            ));
  }

  void noPayment(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              elevation: 24,
              title: Text("Choose Payment Method ",
                  maxLines: 2,
                  style: ThemeFonts.textStyle600.copyWith(fontSize: 18),
                  textAlign: TextAlign.left),
              actions: <Widget>[
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: ThemeColor.primOrange),
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                    child: const Text('OK',
                        style: TextStyle(
                            fontFamily: "NunitoSans", color: Colors.white)))
              ],
            ));
  }

  Future postPayment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String idUser = pref.getString("user")!;
    var response = await http.post(Env().postPayment(),
        body: jsonEncode({
          "price": cartTotalPrice(),
          "payment": holder,
          "user": idUser,
          "idPayment": getId
        }),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body["msg"]);
    }
  }

  Future postHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String idUser = pref.getString("user")!;
    var response = await http.post(Env().postPaymentHistory(),
        body: jsonEncode({
          "user": idUser,
        }),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body["msg"]);
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("yuhuMantap", body["msg"]);
    }
  }

  Future getPayment() async {
    final response = await http.get(Env().getPayment());
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(body);
      setState(() {
        category = body;
      });
    }
    print(category);
  }

  Future getDataList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String idUser = pref.getString("user")!;
    print(idUser);
    final response = await http.get(Env().getCartProduct(idUser));
    cart.clear();
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(body);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString("user", body['token']);
      setState(() {
        //_loading = false;
        Iterable it = jsonDecode(response.body);
        print(response.body);
        cart = it.map((e) => CartFood.fromJson(e)).toList();
      });
      return cart;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          margin: EdgeInsets.all(20),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                //side: BorderSide(color: Colors.red)
            ),
            color: ThemeColor.white,
            child: Text("PAY",style: ThemeFonts.tPrice.copyWith(color: ThemeColor.black),),
            onPressed: () {
              if (selectedUser != null) {
                getDropDownItem();
                print(getId);
                setState(() {
                  validatePayment(context);
                });
              } else {
                setState(() {
                  noPayment(context);
                });
              }
            },
          )),
      backgroundColor: ThemeColor.primOrange,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: ThemeColor.white
              //border: Border.all(color: ThemeColor.primOrange, width: 2)
              ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              check(),
              list(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Total", style: ThemeFonts.textStyle600),
                Text(
                  "Rp " + cartTotalPrice().toString(),
                  style: ThemeFonts.textStyle300,
                )
              ]),
              Text(
                "Choose the Payment",
                textAlign: TextAlign.left,
                style: ThemeFonts.textStyle500,
              ),
              rbPayment(),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemContent(String name, int qty, int price) {
    return Container(
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            qty.toString(),
            style: ThemeFonts.textItem.copyWith(fontSize: 16),
          ),
          Text(name, style: ThemeFonts.textItem.copyWith(fontSize: 16)),
          Text("Rp " + prices(price, qty).toString(),
              style: ThemeFonts.textItem.copyWith(fontSize: 16)),
        ],
      ),
    );
  }

  Widget check() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 5),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 5, color: ThemeColor.orange))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.check_circle_outline_outlined,
            color: ThemeColor.orange,
            size: 75,
          ),
          Text(
            "Inv.  " + getId,
            style: ThemeFonts.textItem.copyWith(fontSize: 18),
          ),
        ]));
  }

  Widget list() {
    return Expanded(
      flex: 1,
      child: Container(
        height: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: cart.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return itemContent(
                cart[index].name, cart[index].qty, cart[index].price);
          },
        ),
      ),
    );
  }

  Widget rbPayment() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButton(
          isExpanded: true,
          value: selectedUser,
            hint: Text(
              'Choose Payment',
              style: ThemeFonts.textStyle300.copyWith(fontSize: 14),
            ),
          items: _dropdownMenuItems,
          onChanged: (selected) {
              setState(() {
                selectedUser = selected as Item?;
              });
          }
        )
      ],
    );
  }
}
