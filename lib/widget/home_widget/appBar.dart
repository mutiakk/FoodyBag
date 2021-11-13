

import 'package:cubaapi/screen/user_screen.dart';
import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: Icon(
                      Icons.format_list_bulleted_outlined,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UserPage()));
                    },
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 30,
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
