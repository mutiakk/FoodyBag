import 'package:cubaapi/screen/home_screen.dart';
import 'package:flutter/material.dart';

class CartPager extends StatefulWidget {
  const CartPager({Key? key}) : super(key: key);

  @override
  _CartPagerState createState() => _CartPagerState();
}

class _CartPagerState extends State<CartPager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyHome()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.orange,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 125,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orange,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: contentImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTla_bZ2nuXzZVsd92spm5f3F-rKWicxzVPcQ&usqp=CAU")),
                  Expanded(
                      child: Column(
                    // mainAxisAlignment: MainAxisAlignment.s,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Ayam",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(' Price : '),
                            Text('Rp. 70000'.toString())
                          ]),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 104,
                        height: 30,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // co.updateProduct(
                                  //     co.item[i],
                                  //     co.item[i].qty + 1);
                                },
                                icon: Icon(
                                  Icons.add,
                                  size: 12,
                                ),
                              ),
                              Text("2"),
                              IconButton(
                                onPressed: () {
                                  // co.updateProduct(
                                  //     co.item[i],
                                  //     co.item[i].qty - 1);
                                },
                                icon: Icon(Icons.remove, size: 12),
                              ),
                            ],
                          )
                      ),
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget contentImage(String imag) {
  return Container(
    margin: EdgeInsets.all(5),
    width: 100,
    height: 100,
    decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: NetworkImage(imag), fit: BoxFit.cover)),
  );
}
