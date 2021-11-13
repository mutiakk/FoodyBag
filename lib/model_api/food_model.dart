// class Food {
//   final int id;
//   final String name;
//   final String images;
//   final String serving;
//   final String person;
//   final String desc;
//   final int price;
//   int qty;
//
//   Food(
//       {required this.id,
//       required this.name,
//       required this.images,
//       required this.serving,
//       required this.person,
//       required this.desc,
//       required this.price,
//       required this.qty});
//
//   factory Food.fromJson(dynamic json) {
//     return Food(
//         name: json['name'] as String,
//         images: json['thumbnail_url'] as String,
//         serving: json['country'] as String,
//         person: json['num_servings'].toString(),
//         desc: json['description'] != null
//             ? json['description']
//             : "Sorry, Nothing to show..",
//         price: json['id'],
//         qty: 1,
//         id: json['show_id'] as int);
//   }
//
//   static List<Food> foodSnapshot(List snapshot) {
//     return snapshot.map((data) {
//       return Food.fromJson(data);
//     }).toList();
//   }
//
//   @override
//   String toString() {
//     return 'Food{ name: $name, image: $images, rating: $serving, desc: $desc}';
//   }
// }
