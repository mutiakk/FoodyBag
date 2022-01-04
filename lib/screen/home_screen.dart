import 'package:cubaapi/screen/listFoodBackEnd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: Icon(Icons.list), onPressed: () { Scaffold.of(context).openDrawer(); },
        //   ),
        //   backgroundColor: Colors.white,
        //  ),
        //drawer: SideBarApp(),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child:ListProduct()
                ),
            ],
          ),
        ));
    // Container(
    //   height: MediaQuery.of(context).size.height,
    //   width: MediaQuery.of(context).size.width,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.only(
    //           topRight: Radius.circular(30),
    //           topLeft: Radius.circular(30))),
    //   child: ListProduct(),
  }
}
