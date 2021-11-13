// import 'package:cubaapi/model_api/food_api.dart';
// import 'package:cubaapi/model_api/food_model.dart';
// import 'package:cubaapi/widget/CustomPageHero.dart';
// import 'package:cubaapi/widget/home_widget/wid_card.dart';
// import 'package:flutter/material.dart';
//
// import 'desc_food.dart';
//
// class ListFood extends StatefulWidget {
//   final String title;
//   final String rate;
//   final String thumb;
//   final String person;
//   final String desc;
//
//   const ListFood(
//       {Key? key,
//       required this.title,
//       required this.rate,
//       required this.thumb,
//       required this.person,
//       required this.desc})
//       : super(key: key);
//
//   @override
//   _ListFoodState createState() => _ListFoodState();
// }
//
// class _ListFoodState extends State<ListFood> {
//   late List<Food> _food;
//
//   bool _loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     foodGet();
//   }
//
//   Future<void> foodGet() async {
//     _food = await FoodApi.getFood();
//     setState(() {
//       _loading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _loading
//           ? Center(child: CircularProgressIndicator())
//           : Container(
//               decoration: BoxDecoration(
//                   color: Colors.grey.withOpacity(0.3),
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(30),
//                       topLeft: Radius.circular(30))),
//               child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2),
//                   itemCount: _food.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             CustomHero(
//                                 page: DescFood(
//                               data: {'example': _food[index]},
//                             )));
//                       },
//                       //   Navigator.push(
//                       //       context,
//                       //       CustomHero(page: DescFood(
//                       //         data: {'example': _food[index]},
//                       //       )));
//                       // },
//                       // child: Hero(
//                       //   tag: 'yuhu_',
//                       child: ListCard(
//                         title: _food[index].name,
//                         rate: _food[index].serving,
//                         thumb: _food[index].images,
//                         person: _food[index].person.toString(),
//                       ),
//                     );
//                   })),
//     );
//   }
// }
