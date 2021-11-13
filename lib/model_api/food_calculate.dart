import 'dart:collection';

import 'package:cubaapi/model_api/food_model.dart';
import 'package:flutter/cupertino.dart';

import 'foodModel2.dart';

class Price with ChangeNotifier {
  List<FoodModel> _product = [];

  //UnmodifiableListView<Food> get items => UnmodifiableListView(_product);
  double _price = 0.0;
  var c = 0;

  void add(FoodModel food) {
    int index = _product.indexWhere((i) => i.name == food.name);
    print(index);
    if (index != -1)
      updateProduct(food, food.qty + 1);
    else {
      _product.add(food);
      calculateTotal();
      notifyListeners();
    }
  }


  void remove(FoodModel food) {
    int index = _product.indexWhere((i) => i.name == food.name);
    _product[index].qty = 1;
    _product.removeWhere((item) => item.name == food.name);
    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    _product.forEach((f) => f.qty = 1);
    _product = [];
    notifyListeners();
  }

  int get count {
    return _product.length;
  }

  double get total {
    return _price;
  }

  List<FoodModel> get item {
    return _product;
  }

  calculateTotal() {
    _price = 0;
    _product.forEach((f) {
      _price += f.price * f.qty;
    });
  }

  void updateProduct(FoodModel food, qty) {
    int index = _product.indexWhere((i) => i.name == food.name);
    _product[index].qty = qty;
    if (_product[index].qty == 0) remove(food);
    calculateTotal();
    notifyListeners();
  }
}
