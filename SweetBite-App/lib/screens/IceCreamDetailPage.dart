import 'package:flutter/material.dart';

class IceCreamDetailPage extends StatelessWidget {
  final dynamic iceCream;

  // Accept the ice cream details as a parameter
  IceCreamDetailPage({required this.iceCream});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(iceCream["title"]),
        backgroundColor: const Color(0xff96CEB4),
      ),
      backgroundColor: const Color(0xFFFBFBFB),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                iceCream["url"],
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.image_not_supported, size: 100),
              ),
            ),
            SizedBox(height: 20),
            // Display other details
            Text(
              iceCream["title"],
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              iceCream["description"] ?? "Delicious treat",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Price: ₹${iceCream["price"]}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
