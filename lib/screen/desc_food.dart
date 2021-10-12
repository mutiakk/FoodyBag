import 'package:cubaapi/model_api/food_calculate.dart';
import 'package:cubaapi/screen/cart_page.dart';
import 'package:cubaapi/widget/CustomPageHero.dart';
import 'package:cubaapi/widget/desc_widget/appBarDesc.dart';
import 'package:cubaapi/widget/desc_widget/content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DescFood extends StatefulWidget {
  // final String data;
  // // final String images;
  // // final String serving;
  // // final String person;
  // // final String desc;
  //
  // const DescFood(
  //     {Key? key,
  //     required this.data,
  //     // required this.images,
  //     // required this.serving,
  //     // required this.person,
  //     // required this.desc,
  //     })
  //     : super(key: key);
  //
  Map<String, dynamic> data;

  //final Food food;

  DescFood({Key? key, required this.data});

//required this.data
  @override
  _DescFoodState createState() => _DescFoodState();
}

class _DescFoodState extends State<DescFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          child: Consumer<Price>(
            builder: (context, count, child) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ButtonTheme(
                      minWidth: 300,
                      height: 30,
                      child: RaisedButton(
                        onPressed: () {
                          count.add(widget.data['example']);
                        },
                        color: Colors.blueGrey[50],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          'Add To Cart',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blueGrey),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CustomHero(
                                  page: CartPage()));
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.blueGrey,
                        ))
                  ],
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          // child: Hero(
          //     tag: 'yuhu_',
          child: Column(children: [
            DescAppBar(
              title: widget.data['example'].name,
            ),
            Container(
              child: ContentDesc(
                title: widget.data['example'].name,
                rate: widget.data['example'].serving,
                thumb: widget.data['example'].images,
                person: widget.data['example'].person.toString(),
                desc: widget.data['example'].desc,
                price: widget.data['example'].price.toString(),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            //     Container(
            //         padding: EdgeInsets.all(10),
            //         margin: EdgeInsets.all(20),
            //         child: Consumer<Price>(builder: (context, count, child) {
            //           return RaisedButton(
            //             onPressed: () {
            //               count.add(widget.data['example']);
            //             },
            //             color: Colors.blueGrey[50],
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(30)),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   'Add To Cart',
            //                   style: TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: 20,
            //                       color: Colors.blueGrey),
            //                 ),
            //                 Icon(
            //                   Icons.shopping_cart,
            //                   color: Colors.blueGrey,
            //                 )
            //               ],
            //             ),
            //           );
            //         })),
            //     IconButton(
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) => CartPage()),
            //           );
            //         },
            //         icon: Icon(Icons.shopping_cart))
            //   ],
            // )
          ]),
        ));
  }
}
