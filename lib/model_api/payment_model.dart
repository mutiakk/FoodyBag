class PaymentMethode {
  String? bank;
  String? va;

  PaymentMethode({this.bank,this.va});

  static List<PaymentMethode> getUsers() {
    return <PaymentMethode>[
      PaymentMethode(
        bank: "mandiri",
        va: "0867557657"
      ),
    ];
  }
}
// List<PaymentMethod> payment() {
//   return <PaymentMethod>[
//     PaymentMethod(
//       bank: 'Bank BCA',
//       description: 'Bank BCA Virtual Account',
//       idBank: 'KUTBVA01',
//       admin: 3000,
//       hintPayment: "Log in ke Mobile Banking\n" +
//           "Pilih “Pembayaran”\n" +
//           "Pilih “BRIVA”\n" +
//           "Masukkan nomor BRI Virtual Account dan jumlah pembayaran\n" +
//           "Masukkan nomor PIN anda\n" +
//           "Tekan “OK” untuk melanjutkan transaksi\n" +
//           "Transaksi berhasil\n" +
//           "SMS konfirmasi akan masuk ke nomor telepon anda",
//     )
//   ];
// }
