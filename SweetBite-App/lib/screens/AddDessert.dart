import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddDessertPage extends StatefulWidget {
  final String categoryId;

  AddDessertPage({required this.categoryId});

  @override
  _AddDessertPageState createState() => _AddDessertPageState();
}

class _AddDessertPageState extends State<AddDessertPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();

  Future<void> addDessert() async {
    try {
      // Retrieve user ID from local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userid = prefs.getString('userid');
      String? authtoken = prefs.getString('authtoken');

      if (userid == null || authtoken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User ID not found. Please log in.")),
        );
        return;
      }

      final response = await http.post(
        Uri.parse('https://cakeshop-api.vercel.app/api/v1/add-dessert'),
        headers: {
          "Content-Type": "application/json",
          "id" : userid,
          "authorization":"Bearer $authtoken",
        },
        body: json.encode({
          "title": titleController.text,
          "price": priceController.text,
          "desc": descriptionController.text,
          "stock": stockController.text,
          "url": imageUrlController.text,
          "shopName": shopNameController.text,
          "uploader_id": userid,
          "category": widget.categoryId,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Dessert added successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add dessert")),

        );
      }
    } catch (error) {
      print("Error adding dessert: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add your Item"),
        backgroundColor: const Color(0xff96CEB4),
      ),
      backgroundColor: const Color(0xFFFBFBFB),

      body: Padding(
        padding: EdgeInsets.all(16.0),

        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title",border: OutlineInputBorder(),),

              ),
              SizedBox(height: 10,),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Price",border: OutlineInputBorder(),),
              ),
              SizedBox(height: 10,),

              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description",border: OutlineInputBorder(),),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Stock",border: OutlineInputBorder(),),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: "Image URL",border: OutlineInputBorder(),),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: shopNameController,
                decoration: InputDecoration(labelText: "Shop Name",border: OutlineInputBorder(),),
              ),
              SizedBox(height: 10,),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addDessert,
                child: Text("Add Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
