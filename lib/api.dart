class Env{
  String baseURL="http://localhost:3000";

  Uri postLoginCustomer() {
    return Uri.parse(baseURL + "/api/login");
  }
  Uri postRegistCustomer() {
    return Uri.parse(baseURL + "/api/sign-up");
  }
}