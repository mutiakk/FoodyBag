import 'package:cubaapi/model_api/history_model.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';

class ReceiptWidget extends StatefulWidget {
  Map<String, dynamic> history;

  // final FoodModel data;

  ReceiptWidget({Key? key, required this.history});

  @override
  _ReceiptWidgetState createState() => _ReceiptWidgetState();
}

class _ReceiptWidgetState extends State<ReceiptWidget> {
  late final HistoryModel dHistory;
  DateTime _dateTime = DateTime.now();

  String dateTimeOrder(DateTime date) {
    _dateTime = date;
    return DateFormat('dd-MM-yyyy hh:mm a').format(date);
  }

  final _screenshotController = ScreenshotController();

  void _takeScreenshot() async {
    final imageFile = await _screenshotController.capture();
    Share.shareFiles([imageFile.path], text: "Shared from Foody Bag");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.orange,
      body: Stack(
        children: <Widget>[
          Screenshot(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: ThemeColor.primOrange.withOpacity(0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  item(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0),
                                  color: ThemeColor.primOrange),
                              child: Center(
                                  child: IconButton(
                                      onPressed: () async {
                                        _takeScreenshot();
                                      },
                                      tooltip: 'increament',
                                      icon: Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ))),
                            ),
                            Text(
                              'Share',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0),
                                  color: ThemeColor.primOrange),
                              child: Center(
                                child: Icon(
                                  Icons.print,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ),
                            Text(
                              'Print',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: EdgeInsets.only(left:10,right: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 30.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border:
                                Border.all(color: ThemeColor.primOrange, width: 2),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            'Done',
                            style: TextStyle(
                                color:ThemeColor.primOrange, fontSize: 15.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            controller: _screenshotController,
          )
        ],
      ),
    );
  }

  Widget item() {
    return Center(
      child: ClipPath(
        clipper: ZigZagClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 8),
                child: Container(
                    width: 130.0,
                    height: 112.0,
                    child: Column(
                      children: [
                        Text("Queue Number:",
                            style: ThemeFonts.textItem.copyWith(fontSize: 16)),
                        Text(widget.history['esp'].id.toString(),
                            style: ThemeFonts.tPrice.copyWith(fontSize: 60))
                      ],
                    )),
              ),
              Text('Success!',
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text('Payment is completed ',
                    style: TextStyle(
                        fontSize: 15.0, color: ThemeColor.primOrange)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text('Cashier', style: TextStyle(fontSize: 12.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Text(
                      dateTimeOrder(widget.history['esp'].date),
                      style: TextStyle(fontSize: 12.0),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  width: 300.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey, width: 1.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 35.0,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Inv. ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            Text(
                              widget.history['esp'].idPayment,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          widget.history['esp'].payment,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Total Amount",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Rp " + widget.history['esp'].price.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(3.0, size.height - 10.0);

    var firstControlPoint = Offset(23.0, size.height - 40.0);
    var firstEndPoint = Offset(38.0, size.height - 5.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(58.0, size.height - 40.0);
    var secondEndPoint = Offset(75.0, size.height - 5.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset(93.0, size.height - 40.0);
    var thirdEndPoint = Offset(110.0, size.height - 5.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    var fourthControlPoint = Offset(128.0, size.height - 40.0);
    var fourthEndPoint = Offset(150.0, size.height - 5.0);
    path.quadraticBezierTo(fourthControlPoint.dx, fourthControlPoint.dy,
        fourthEndPoint.dx, fourthEndPoint.dy);

    var fifthControlPoint = Offset(168.0, size.height - 40.0);
    var fifthEndPoint = Offset(185.0, size.height - 5.0);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fifthEndPoint.dx, fifthEndPoint.dy);

    var sixthControlPoint = Offset(205.0, size.height - 40.0);
    var sixthEndPoint = Offset(220.0, size.height - 5.0);
    path.quadraticBezierTo(sixthControlPoint.dx, sixthControlPoint.dy,
        sixthEndPoint.dx, sixthEndPoint.dy);

    var sevenControlPoint = Offset(240.0, size.height - 40.0);
    var sevenEndPoint = Offset(255.0, size.height - 5.0);
    path.quadraticBezierTo(sevenControlPoint.dx, sevenControlPoint.dy,
        sevenEndPoint.dx, sevenEndPoint.dy);

    var eightControlPoint = Offset(275.0, size.height - 40.0);
    var eightEndPoint = Offset(290.0, size.height - 5.0);
    path.quadraticBezierTo(eightControlPoint.dx, eightControlPoint.dy,
        eightEndPoint.dx, eightEndPoint.dy);

    var ninthControlPoint = Offset(310.0, size.height - 40.0);
    var ninthEndPoint = Offset(330.0, size.height - 5.0);
    path.quadraticBezierTo(ninthControlPoint.dx, ninthControlPoint.dy,
        ninthEndPoint.dx, ninthEndPoint.dy);

    path.lineTo(size.width, size.height - 10.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
