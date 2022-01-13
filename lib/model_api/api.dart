class Env{
  String baseURL="http://10.1.6.215:3560";

  Uri postLoginCustomer() {
    return Uri.parse(baseURL + "/api/login");
  }
  Uri postRegistCustomer() {
    return Uri.parse(baseURL + "/api/register");
  }
  Uri getListProduct(){
    return Uri.parse(baseURL+"/api/listProduct");
  }
  Uri postCartProduct(){
    return Uri.parse(baseURL+"/api/addToCart");
  }
  Uri getCartProduct(String user){
    return Uri.parse(baseURL+"/api/cart-list/"+ user);
  }
  Uri plusCart(){
    return Uri.parse(baseURL+"/api/cartPlus");
  }
  Uri minCart(){
    return Uri.parse(baseURL+"/api/cartMin");
  }
  Uri delCart(String idOrder){
    return Uri.parse(baseURL+"/api/cart-list/"+ idOrder);
  }
  Uri getPayment(){
    return(Uri.parse(baseURL+"/api/listPayment"));
  }
  Uri postPayment(){
    return(Uri.parse(baseURL+"/api/payment-fix"));
  }
  Uri getListPayment(String idUser){
    return(Uri.parse(baseURL+"/api/payment-list/"+idUser));
  }
  Uri postPaymentHistory(){
    return(Uri.parse(baseURL+"/api/payment-history"));
  }
  Uri getAfterPayment(String idUser){
    return(Uri.parse(baseURL+"/api/payment-after/"+idUser));
  }
}