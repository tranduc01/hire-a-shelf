import 'package:grocery_app/models/account.dart';

class JwtResponse {
  final String token;
  final Account account;
  final DateTime expiredDate;
  final String message;
  JwtResponse(
      {required this.token,
      required this.account,
      required this.expiredDate,
      required this.message});
  factory JwtResponse.fromJson(Map<String, dynamic> json) {
    return JwtResponse(
        token: json['token'].toString(),
        account: Account.fromJson(json['account']),
        expiredDate: DateTime.parse(json['expiredDate']),
        message: json['message'].toString());
  }
}

// Future<JwtResponse> attemptLogIn(String username, String password) async {
//   var res = await http.post(
//     Uri.parse("http://10.0.2.2:9090/api/auth"),
//     body: jsonEncode({"userName": username, "password": password}),
//     headers: {'Content-Type': "application/json"},
//   );
//   if (res.statusCode == 200) {
//     return (json.decode(res.body)).map((e) => JwtResponse.fromJson(e));
//   } else {
//     return throw Exception("Fail to fetch.");
//   }
// }
