import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {
  final storage = FlutterSecureStorage();

  Future removeTokens() async {
    await storage.delete(key: "refreshToken");
    await storage.delete(key: "idToken");
  }

  Future<String> getRefreshToken() async {
    final String refreshToken = await storage.read(key: "refreshToken");
    final result = await http.post(
        "https://dashboard.airveda.com/api/token/refresh/",
        body: {"refreshToken": refreshToken});
    if (result.statusCode == 200) {
      final idToken = json.decode(result.body)["idToken"];
      storage.write(key: "jwt", value: idToken);
      storage.write(
          key: "refreshToken", value: json.decode(result.body)["refreshToken"]);
      return idToken;
    } else {
      return null;
    }
  }

  Future<String> getToken() async {
    try {
      final String token = await storage.read(key: "jwt");
      if (token != null) {
        final payload = json.decode(
            ascii.decode(base64.decode(base64.normalize(token.split(".")[1]))));
        if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
            .isAfter(DateTime.now())) {
          return token;
        } else {
          return await getRefreshToken().then((value) => value);
        }
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
