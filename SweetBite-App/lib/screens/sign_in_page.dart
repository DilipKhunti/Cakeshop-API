import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/sign_up_page.dart';
import 'package:untitled/services/auth_service.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void signIn() async {
    String username = usernameController.text;
    String password = passwordController.text;

    var response = await authService.signIn(username, password);
    if (response != null && response['token'] != null && response['id'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authtoken', response['token']);
      await prefs.setString('userid', response['id']);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid Credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ice-cream3.avif"),
            fit: BoxFit.cover, // Ensures full background coverage
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers content
            children: [
              Text('Sign - in', style: TextStyle(fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),),
              SizedBox(height: 20,),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: signIn,
                child: Text("Sign In"),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.blue), // Optional, change button color
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text("Don't have an account? Sign Up"),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white30), // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
