import 'package:cubaapi/screen/history_screen.dart';
import 'package:cubaapi/screen/cart_screen.dart';
import 'package:cubaapi/screen/login_screen.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBarApp extends StatefulWidget {
  const SideBarApp({Key? key}) : super(key: key);

  @override
  _SideBarAppState createState() => _SideBarAppState();
}

class _SideBarAppState extends State<SideBarApp> {
  String token = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("login")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.85,
          child:Drawer(child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: ThemeColor.primOrange,)),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Home'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('My Cart'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Keranjang()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.watch_later_outlined),
            title: Text('History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: ()async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
            },
          ),
        ],
      ),)
      ),
    );
  }
}
