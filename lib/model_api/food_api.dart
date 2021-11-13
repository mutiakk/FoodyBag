// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'food_model.dart';
//
//
// class FoodApi{
//
//   static Future <List<Food>> getFood() async{
//     var url= Uri.https('tasty.p.rapidapi.com', '/recipes/list',
//         {"from": "0",
//           "size": "20",
//           "tags": "under_30_minutes" });
//
//   final response= await http.get(url,headers: {
//     "x-rapidapi-host": "tasty.p.rapidapi.com",
//     "x-rapidapi-key": "aefd677b3amshc64fef225fbcef6p157cf1jsn3fa135194e2e",
//     "useQueryString": "true"
//   });
//
//   Map data= jsonDecode(response.body);
//
//   List _foodTemporary=[];
//
//   for (var u in data['results']){
//     _foodTemporary.add(u);
//   }
//   return Food.foodSnapshot(_foodTemporary);
//
// }}