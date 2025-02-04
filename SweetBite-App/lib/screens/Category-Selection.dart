import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled/screens/AddDessert.dart';


class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"],
      name: json["name"],
    );
  }
}

class CategorySelectionPage extends StatefulWidget {
  @override
  _CategorySelectionPageState createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  String? selectedCategoryId;
  List<Category> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://cakeshop-api.vercel.app/api/v1/get-all-categories'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> categoryData = responseData["data"];

        setState(() {
          categories = categoryData.map((json) => Category.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching categories: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Category"),
        backgroundColor: const Color(0xff96CEB4),
      ),
      backgroundColor: const Color(0xFFFBFBFB),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
         //   mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: DropdownButton<String>(
                  value: selectedCategoryId,
                  hint: Text("Select a category"),
                  isExpanded: true,
                  items: categories.map((Category category) {
                    return DropdownMenuItem<String>(
                      value: category.id, // Pass ID to backend
                      child: Text(category.name), // Show Name in UI
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategoryId = newValue;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedCategoryId != null
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddDessertPage(categoryId: selectedCategoryId!),
                    ),
                  );
                }
                    : null, // Disable button if no category is selected
                child: Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
