import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DessertsUploadedByUserPage extends StatefulWidget {
  @override
  _DessertsUploadedByUserPageState createState() => _DessertsUploadedByUserPageState();
}

class _DessertsUploadedByUserPageState extends State<DessertsUploadedByUserPage> {
  List<dynamic> desserts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDesserts();
  }

  Future<void> fetchDesserts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    String? authtoken = prefs.getString('authtoken');

    if (userid == null || authtoken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User ID not found. Please log in.")),
      );
      return;
    }

    final Uri uri = Uri.parse('https://cakeshop-api.vercel.app/api/v1/get-desserts-by-uploader');
    final Map<String, String> headers = {
      "id": userid,
      "authorization": "Bearer $authtoken",
      "Content-Type": "application/json",
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'Success') {
          setState(() {
            desserts = data['data'];
            isLoading = false;
          });
        } else {
          // Handle the case where the status is not 'Success'
          setState(() {
            isLoading = false;
          });
        }
      } else {
        // Handle the case where the response status code is not 200
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle any errors that occur during the request
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Uploaded by User'),
        backgroundColor: const Color(0xff96CEB4),
      ),
      backgroundColor: const Color(0xFFFBFBFB),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : desserts.isEmpty
          ? Center(child: Text('No desserts found.'))
          : ListView.builder(
        itemCount: desserts.length,
        itemBuilder: (context, index) {
          final dessert = desserts[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26, // Shadow color
                  blurRadius: 10, // Spread of shadow
                  offset: Offset(0, 4), // Shadow position
                ),
              ],
            ),
            child: ListTile(
              leading: Image.network(dessert['url']),
              title: Text(dessert['title']),
              subtitle: Text('${dessert['price']} - ${dessert['shopName']}'),
              trailing: Text('Stock: ${dessert['stock']}'),
              onTap: () {
                // Handle onTap action
              },
            ),
          );
        },
      ),
    );
  }
}
