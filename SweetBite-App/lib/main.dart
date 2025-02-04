import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/home_page.dart';
import 'package:untitled/screens/sign_in_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Icecream App',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  Future<bool> _isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authtoken = prefs.getString('authtoken');
    String? userid = prefs.getString('userid');
    return authtoken != null && userid != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          bool isLoggedIn = snapshot.data ?? false;
          return isLoggedIn ? HomePage() : SignInPage();
        }
      },
    );
  }
}
