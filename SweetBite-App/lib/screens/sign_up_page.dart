import 'package:flutter/material.dart';
import 'package:untitled/services/auth_service.dart';
import 'sign_in_page.dart';


class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/ice-cream5.avif"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign - up', style: TextStyle(fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white),),
            SizedBox(height: 20,),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: "Name", border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: "Password", border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final success = await AuthService().signUp(
                  nameController.text,
                  emailController.text,
                  passwordController.text,
                  addressController.text,
                );

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Sign Up Successful!")));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Sign Up Failed!")));
                }
              },
              child: Text("Sign Up"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.blue), // Optional, change button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
