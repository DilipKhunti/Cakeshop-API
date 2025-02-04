import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/Category-Selection.dart';
import 'package:untitled/screens/sign_in_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Retrieve userid and authtoken from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    String? authtoken = prefs.getString('authtoken');

    if (userid == null || authtoken == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse('https://cakeshop-api.vercel.app/api/v1/get-user-information');
    final headers = {
      'id': userid, // Use the userid from local storage
      'authorization': 'Bearer $authtoken', // Use the authtoken from local storage
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        setState(() {
          userData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print('Failed to load user data: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching user data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears stored auth token and user ID

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page'),
        backgroundColor: Color(0xFFBCCCDC),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Calls logout function
          ),
        ],
      ),
      backgroundColor: Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : userData == null
            ? Center(child: Text('Failed to load user data'))
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
        
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userData!['avatar']),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  userData!['username'],
                  style: TextStyle(fontSize: 22, ),
        
                ),
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(userData!['email'],
                      style: TextStyle(fontSize: 16))),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(userData!['address'],
                      style: TextStyle(fontSize: 16))),
              SizedBox(height: 10),
              Container(
              //  padding: EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: TextButton(
                  onPressed:
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategorySelectionPage(),
                        )
        
                    );
                  },
                  child: Text("Add-your-iteam"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}