import 'package:flutter/material.dart';

class DescAppBar extends StatelessWidget {
  final String title;

  const DescAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20),
                maxLines: 2,
              )
            ]),
          ),
        ),
      ],
    );
  }
}
