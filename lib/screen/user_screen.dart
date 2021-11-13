import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String user = "";
  String id = "";
  String username = "";
  String password="";
  String login="";
  String registered="";
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user = pref.getString("user")!;
      String? userPref = pref.getString("login");
      Map<String,dynamic> userMap = jsonDecode(userPref!) as Map<String, dynamic>;
      print(userMap);
      String id = userMap['id'];
      print(id);
      username = userMap['username'];
      //String password=userMap['password'];
      login=userMap['login'];
      registered=userMap['registered'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Detail'),),
      body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey
                  // image: DecorationImage(
                  //     image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                  //     fit: BoxFit.fill
                  // ),
                ),
              ),
              Text(username,style: TextStyle(fontSize: 30,),),
              Text(user)
            ],
          ),
        ),
      );
  }
}
