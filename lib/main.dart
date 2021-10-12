import 'package:cubaapi/screen/desc_food.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model_api/food_calculate.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Price())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

