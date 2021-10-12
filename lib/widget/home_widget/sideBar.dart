import 'package:cubaapi/screen/cart_page.dart';
import 'package:flutter/material.dart';

class SideBarApp extends StatelessWidget {

  const SideBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            'Side menu',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          decoration: BoxDecoration(
              color: Colors.grey,)),
        ListTile(
          leading: Icon(Icons.input),
          title: Text('Welcome'),
          onTap: () => {Navigator.of(context).pop()},
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Cart'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
        ),
      ],
    ),
    );
  }
}
