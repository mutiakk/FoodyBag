import 'package:cubaapi/screen/list_screen.dart';
import 'package:cubaapi/widget/home_widget/appBar.dart';
import 'package:cubaapi/widget/home_widget/sideBar.dart';
import 'package:cubaapi/widget/home_widget/wid_hello.dart';
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
      //   title: Text ('ReciFood', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueGrey,wordSpacing: 5),),
      // ),
      drawer: SideBarApp(),
      body: SingleChildScrollView(
        child: Container(
          //decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Column(
                  children: [
                    BarBar(),
                    HelloWidget(),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: ListFood(rate: '', title: '', person: '', thumb: '',desc:''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
