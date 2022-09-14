import 'package:authapi/widget/cons.dart';
import 'package:http/http.dart' as http;

class CustomHttp {
  var map = <String, dynamic>{};
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json"
  };
  Future<String> loginUser(String email, String password) async {
    var link = "${baseUrl}api/admin/sign-in";
    map["email"] = email;
    map["password"] = password;
    var response =
        await http.post(Uri.parse(link), body: map, headers: defaultHeader);
    print(response.body);
    if (response.statusCode == 200) {
      showtoast("Login Successfull!");
      return response.body;
    } else {
      showtoast("Invalid Email or Password.....");
      return "Something went wrong";
    }
  }
}
