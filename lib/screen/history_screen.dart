import 'dart:convert';
import 'package:cubaapi/model_api/api.dart';
import 'package:cubaapi/model_api/history_model.dart';
import 'package:cubaapi/theme/colors.dart';
import 'package:cubaapi/theme/fonts.dart';
import 'package:cubaapi/widget/CustomPageHero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/receipt_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var history = <HistoryModel>[];
  DateTime _dateTime = DateTime.now();

  String dateTimeOrder(DateTime date) {
    _dateTime = date;
    return DateFormat('dd-MM-yyyy hh:mm a').format(date);
  }

  Future getDataList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String idUser = pref.getString("user")!;
    print(idUser);
    final response = await http.get(Env().getListPayment(idUser));
    if (response.statusCode == 200) {
      setState(() {
        Iterable it = jsonDecode(response.body);
        print(response.body);
        history = it.map((e) => HistoryModel.fromJson(e)).toList();
      });
      return history;
    }
  }

  @override
  void initState() {
    super.initState();
    getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order History",
          style: ThemeFonts.textStyle500.copyWith(color: ThemeColor.white),
        ),backgroundColor: ThemeColor.primOrange,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      CustomHero(
                          page: ReceiptWidget(
                            history: {'esp': history[i]},
                          )));
                },
                child: Column(
                  children: [
                    listPayment(
                        history[i].id.toString(),
                        history[i].idPayment,
                        dateTimeOrder(history[i].date),
                        history[i].price.toString()),
                    //SizedBox(height: 10,)
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget listPayment(String id, idPayment, dateTime, price) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      height: 80.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey, width: 1.0)),
      child: ListTile(
        leading: Text(
          id,
          style: ThemeFonts.tPrice
              .copyWith(color: ThemeColor.orange, fontSize: 35),
        ),
        title: Text(
          'Inv.  ' + idPayment,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
        subtitle: Text(
          dateTime,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12.0),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            "Rp "+price,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12.0),
          ),
        ),
      ),
    );
  }
}
