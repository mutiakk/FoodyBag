import 'package:cubaapi/screen/history_screen.dart';
import 'package:cubaapi/screen/cart_screen.dart';
import 'package:cubaapi/screen/login_screen.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBarApp extends StatefulWidget {
  const SideBarApp({Key? key}) : super(key: key);

  @override
  _SideBarAppState createState() => _SideBarAppState();
}

class _SideBarAppState extends State<SideBarApp> {
  String token = "";
  String name = "";
  String username = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("login");
      name = pref.getString("name");
      username = pref.getString("username");
    });
    print(username);
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    child: Align(
                      child:Column(
                        children: [
                          Text(
                              name,
                              style: ThemeFonts.textStyle600
                                  .copyWith(color: ThemeColor.white, fontSize: 30),
                              textAlign: TextAlign.left,
                            ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '@' + username,
                            style: ThemeFonts.textStyle300
                                .copyWith(color: ThemeColor.white, fontSize: 12),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),alignment: Alignment.centerLeft,),

                    decoration: BoxDecoration(
                      color: ThemeColor.primOrange,
                    )),
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
                  onTap: () {
                    setState(() {
                      _validateLogout(context);
                    });
                  },
                ),
              ],
            ),
          )),
    );
  }

  void _validateLogout(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              elevation: 30,
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
                  Text("Are You Sure to Logout?",
                      textAlign: TextAlign.center,
                      style: ThemeFonts.textStyle600
                          .copyWith(color: ThemeColor.primOrange)),
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
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.clear();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    },
                    child: const Text('OK',
                        style: TextStyle(
                            fontFamily: "NunitoSans", color: Colors.white)))
              ],
            ));
  }
}
