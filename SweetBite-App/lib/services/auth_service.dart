import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "https://cakeshop-api.vercel.app/api/v1";

  Future<Map<String, dynamic>?> signIn(String username, String password) async {
    final url = Uri.parse('$baseUrl/sign-in');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }


  Future<bool> signUp(String username, String email, String password, String address) async {
    final url = Uri.parse('$baseUrl/sign-up');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'address': address,
      }),
    );

    return response.statusCode == 200;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
