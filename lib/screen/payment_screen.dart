// import 'package:cubaapi/model_api/checkout_model.dart';
// import 'package:cubaapi/model_api/hintPay_model.dart';
// import 'package:cubaapi/model_api/payment_model.dart';
// import 'package:flutter/material.dart';
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key? key}) : super(key: key);
//
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Color(0xFF6991C7)),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         title: Text(
//           'Payment',
//           style: TextStyle(
//               fontFamily: "Gotik",
//               fontSize: 18.0,
//               color: Colors.black54,
//               fontWeight: FontWeight.w700),
//         ),
//         elevation: 0.0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Congratulations!',
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               '1 Langkah lagi pesanan anda akan di proses, mohon lakukan transfer',
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16.0),
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   children: [
//                     Text("",
//                       style: TextStyle(
//                         fontSize: 16.0,
//                       ),
//                     ),
//             //         const SizedBox(height: 16.0),
//             //         Container(
//             //           alignment: Alignment.center,
//             //           padding: const EdgeInsets.symmetric(horizontal: 8),
//             //           decoration: BoxDecoration(
//             //             border: Border.all(
//             //               width: 1,
//             //               color: Colors.grey,
//             //             ),
//             //           ),
//             //           child: Row(
//             //             children: [
//             //               Expanded(
//             //                 child: Text(""
//             //                   ),
//             //                 ),
//             //               IconButton(
//             //                 iconSize: 18,
//             //                 onPressed: () {
//             //                   ScaffoldMessenger.of(context).showSnackBar(
//             //                     SnackBar(
//             //                       content:
//             //                       Text('Kode Virtual Akun sudah di salin'),
//             //                     ),
//             //                   );
//             //                 },
//             //                 icon: Icon(Icons.document_scanner),
//             //               )
//             //             ],
//             //           ),
//             //         ),
//             //         const SizedBox(height: 9.0),
//             //         Text('Biaya Admin'),
//             //         Text(
//             //           bank.admin.toString(),
//             //           style: TextStyle(
//             //             fontWeight: FontWeight.bold,
//             //             fontSize: 16.0,
//             //           ),
//             //         ),
//             //         const SizedBox(height: 16.0),
//             //         Text('Total'),
//             //         Text(
//             //           'Rp ' + data.transactionAmount.format(),
//             //           style: TextStyle(
//             //             fontSize: 24.0,
//             //             fontWeight: FontWeight.bold,
//             //           ),
//             //         ),
//             //         const Divider(),
//             //         Text('Sebelum'),
//             //         Text(data.expiredDate.format()),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//             const SizedBox(height: 16.0),
//             Card(
//               child: Padding(
//                 padding: EdgeInsets.all(24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Hint Payment"),
//                     const SizedBox(height: 10.0),
//                     //HintPayment(bank: bank),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     )])));
//   }
// }
//
// class HintPayment extends StatelessWidget {
//   @required
//   final PaymentMethod bank;
//
//   const HintPayment({Key? key, required this.bank}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         //for (var hintPaymentData in bank.listHintPayment)
//           ExpansionTile(
//             tilePadding: EdgeInsets.symmetric(horizontal: 0),
//             title: Text(
//               ""//hintPaymentData.hintText,
//             ),
//             children: <Widget>[
//              // for (var hint in hintPaymentData.listHint)
//                 ListTile(
//                   leading: MyBullet(),
//                   title: Text(""),
//                 )
//             ],
//           ),
//       ],
//     );
//   }
// }
//
// class MyBullet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       height: 10.0,
//       width: 10.0,
//       decoration: new BoxDecoration(
//         color: Colors.black,
//         shape: BoxShape.circle,
//       ),
//     );
//   }
// }

import 'package:cubaapi/theme/colors.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              child: Icon(
                Icons.check,
                color: ThemeColor.primOrange,
              ),
            )
          ],
        ),
      ),
    );
  }
}
