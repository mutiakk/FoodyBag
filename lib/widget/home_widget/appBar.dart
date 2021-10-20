
import 'package:flutter/material.dart';

class BarBar extends StatelessWidget {
  const BarBar({Key? key}) : super(key: key);

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
                IconButton(onPressed: ()=>
                  Scaffold.of(context).openDrawer(),
                 icon: Icon(Icons.format_list_bulleted_outlined,color: Colors.blueGrey,size: 30,)),
                Text ('ReciFood', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueGrey,wordSpacing: 5),),
                IconButton(onPressed: (){}, icon: Icon(Icons.account_circle,color: Colors.blueGrey,size: 30,))
              ],
            ),
          ),
        ),
      ],

    );
  }
}
