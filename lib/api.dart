import 'package:flutter/cupertino.dart';

class Env{
  String baseURL="http://10.0.2.2:3000";

  Uri postLoginCustomer() {
    return Uri.parse(baseURL + "/api/login");
  }
  Uri postRegistCustomer() {
    return Uri.parse(baseURL + "/api/sign-up");
  }
  Uri getListProduct(){
    return Uri.parse(baseURL+"/api/listProduct");
  }
  Uri postCartProduct(){
    return Uri.parse(baseURL+"/api/addToCart");
  }
  Uri getCartProduct(){
    return Uri.parse(baseURL+"/api/listCart");
  }
  Uri plusCart(){
    return Uri.parse(baseURL+"/api/cartPlus");
  }
  Uri minCart(){
    return Uri.parse(baseURL+"/api/cartmin");
  }
  Uri delCart(String idOrder){
    return Uri.parse(baseURL+"/api/cart/" + idOrder);
  }
}