import 'package:cubaapi/model_api/food_calculate.dart';
import 'package:cubaapi/model_api/food_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'desc_food.dart';

class CartPage extends StatefulWidget {
  //Map<String, dynamic> dataid;
  const CartPage({
    Key? key,
    //required this.dataid
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _cart = CartModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "${_cart.totalPrice}".toString(),
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueGrey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          child: Text(
            'Cart Page',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: _cart.foods.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => DescFood(
                          //                 data: {'example': co.item[i]},
                          //               )));
                        },
                        child: Column(
                          children: [
                            Card(
                                child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child:
                                          buildImage("${_cart.foods[i].image}"),
                                    ),
                                    // child: Image.network(
                                    //     "${co.item[i].images}",height: 100,width:100 ,)),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${_cart.foods[i].name}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(' Price : '),
                                                  Text('${_cart.foods[i].price}'
                                                      .toString())
                                                ]),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    // co.updateProduct(
                                                    //     co.item[i],
                                                    //     co.item[i].qty + 1);
                                                  },
                                                  icon: Icon(
                                                    Icons.add,
                                                    size: 12,
                                                  ),
                                                ),
                                                Text("${_cart.foods[i].qty}"
                                                    .toString()),
                                                IconButton(
                                                  onPressed: () {
                                                    // co.updateProduct(
                                                    //     co.item[i],
                                                    //     co.item[i].qty - 1);
                                                  },
                                                  icon: Icon(Icons.remove,
                                                      size: 12),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 30,
                                  color: Colors.blueGrey[50],
                                  child: Text(
                                    // (co.item[i].qty * co.item[i].price)
                                    5.toString(),
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              ],
                            ))
                          ],
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }

  Widget buildImage(String imag) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: NetworkImage(imag), fit: BoxFit.cover)),
    );
  }
}
