import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/screens/IceCreamDetailPage.dart';

class IceCreamListPage extends StatefulWidget {
  @override
  _IceCreamListPageState createState() => _IceCreamListPageState();
}

class _IceCreamListPageState extends State<IceCreamListPage> {
  List<dynamic> iceCreamList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchIceCreams();
  }

  Future<void> fetchIceCreams() async {
    try {
      final response = await http.get(
        Uri.parse('https://cakeshop-api.vercel.app/api/v1/get-all-desserts'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          iceCreamList = data["data"];
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load ice creams");
      }
    } catch (error) {
      print("Error fetching ice creams: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ice Creams',
              style: GoogleFonts.lato(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Kuch yummy ho jaaye 😋',
              style: GoogleFonts.actor(fontSize: 18),
            ),
          ],
        ),
        backgroundColor: const Color(0xff96CEB4),
      ),
      backgroundColor: const Color(0xFFFBFBFB),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : iceCreamList.isEmpty
          ? Center(child: Text("No ice creams available"))
          : ListView.builder(
        itemCount: iceCreamList.length,
        itemBuilder: (context, index) {
          final iceCream = iceCreamList[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: GestureDetector(
                onTap: () {
                  // Navigate to the IceCreamDetailPage on tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          IceCreamDetailPage(iceCream: iceCream),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        iceCream["url"],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported, size: 100),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            iceCream["title"],
                            style: GoogleFonts.lato(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            iceCream["description"] ?? "Delicious treat",
                            style: GoogleFonts.lato(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Price: ₹${iceCream["price"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
