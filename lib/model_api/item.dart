class Item {
  const Item(this.name, this.method);

  final String name;
  final String method;

  static List<Item> users(){
    return<Item>[
      Item('Cash','Pay at Cashier'),
      Item('Dana','Send to 085780196976 via Dana'),
      Item('Gopay','Send to 085780196976 via GoPay'),
    ];
  }
}

