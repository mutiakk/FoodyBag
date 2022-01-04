class CheckoutResult {
  final String virtualAccount;
  final String channelId;
  final double transactionAmount;
  final DateTime expiredDate;

  CheckoutResult({
    required this.virtualAccount,
    required this.channelId,
    required this.transactionAmount,
    required this.expiredDate,
  });

  factory CheckoutResult.fromJson(Map<String, dynamic> json) => CheckoutResult(
    virtualAccount: json['virtual_account'],
    channelId: json['channel_id'],
    transactionAmount: double.parse(json['transaction_amount']),
    expiredDate: DateTime.parse(json['expired_date']),
  );
}