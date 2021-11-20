import 'package:cubaapi/model_api/foodModel2.dart';

class CartModel {

  static final cartModel = CartModel._internal();

  CartModel._internal();

  factory CartModel() => cartModel;
  // catalog field
  late FoodItem _foodItem;

  // Collection of IDs - store Ids of each item
  final List<int> _id= [];

  // Get Catalog
  FoodItem get foodItem => _foodItem;

  set foodItem(FoodItem newCatalog) => _foodItem= newCatalog;

  List<FoodModel> _product = [];

  // Get items in the cart
  List<FoodModel> get foods => _id.map((id) => _foodItem.getById(id)).toList();

  // Get total price
  num get totalPrice =>
      foods.fold(0, (total, current) => total + current.price);

  // Add Item

  void add(FoodModel item) {
    int index= _product.indexWhere((i) => i.name== item.name);
    print(index);
    if (index!= -1)
      
    _id.add(item.id);
  }

  // Remove Item

  void remove(FoodModel item) {
    _id.remove(item.id);
  }
}