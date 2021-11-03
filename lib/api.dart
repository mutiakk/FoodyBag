class Env{
  String baseURL="http://10.0.2.2:3000";

  Uri postLoginCustomer() {
    return Uri.parse(baseURL + "/api/login");
  }
  Uri postRegistCustomer() {
    return Uri.parse(baseURL + "/api/sign-up");
  }
}