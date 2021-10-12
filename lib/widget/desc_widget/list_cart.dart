import 'package:flutter/material.dart';

class ListCart extends StatefulWidget {
  const ListCart({
    Key? key,
  }) : super(key: key);

  @override
  _ListCartState createState() => _ListCartState();
}

class _ListCartState extends State<ListCart> {
  late String image;
  late String price;
  late String name;
  late String qty;

  late String total;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3)),
          ],
        ),
        child: Row(children: [
          Container(
            margin: EdgeInsets.all(5),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(' Price : '),
                Text(price)
              ]),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      },
                    icon: Icon(
                      Icons.add,
                      size: 12,
                    ),
                  ),
                  Text(qty),
                  IconButton(
                    onPressed: () {
                      //co.updateProduct(co.item[i], co.item[i].qty - 1);
                    },
                    icon: Icon(Icons.remove, size: 12),
                  ),
                  Text(total),
                ],
              )
            ],
          ),
        ]));
  }
}
