import 'package:flutter/material.dart';
import 'package:get/get.dart';  // Pastikan Anda sudah menambahkan get di pubspec.yaml

class SearchViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0E1E1),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0, // Menghilangkan shadow
        automaticallyImplyLeading: false, // Disable default leading back button
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),
            Expanded(
              // Search Bar Container
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30), // Rounded edges
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey), // Search Icon
                    SizedBox(width: 8), // Spacing between icon and text
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Mau makan apa hari ini?', // Updated text
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView( // Bungkus body dengan SingleChildScrollView agar bisa di-scroll
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16), // Padding after AppBar

              // Keyword tags
              Text(
                'Kata kunci',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  _buildTag('Nasi goreng'),
                  _buildTag('Soto'),
                  _buildTag('Ayam goreng'),
                  _buildTag('Salad'),
                  _buildTag('Mi goreng'),
                ],
              ),
              Divider(),
              SizedBox(height: 16),

              // Category section
              Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),

              // Gunakan GridView untuk menampilkan kategori
              GridView.count(
                crossAxisCount: 3, // Ubah menjadi 3 kolom
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true, // Allow GridView to be wrapped in SingleChildScrollView
                physics: NeverScrollableScrollPhysics(), // Disable internal GridView scroll
                children: [
                  _buildFoodCard('Roti', 'assets/images/Container1.png'),
                  _buildFoodCard('Kopi', 'assets/images/Container1.png'),
                  _buildFoodCard('Bakmie', 'assets/images/Container1.png'),
                  _buildFoodCard('Breakfast', 'assets/images/Container1.png'),
                  _buildFoodCard('Salad', 'assets/images/Container1.png'),
                  _buildFoodCard('Nasi', 'assets/images/Container1.png'),
                  _buildFoodCard('Ayam', 'assets/images/Container1.png'),
                  _buildFoodCard('Teh', 'assets/images/Container1.png'),
                  _buildFoodCard('Smoothie', 'assets/images/Container1.png'),
                  _buildFoodCard('Jus Jeruk', 'assets/images/Container1.png'),
                  _buildFoodCard('Susu', 'assets/images/Container1.png'),
                  _buildFoodCard('Air Mineral', 'assets/images/Container1.png'),
                  _buildFoodCard('Cokelat Panas', 'assets/images/Container1.png'),
                  _buildFoodCard('Pizza', 'assets/images/Container1.png'),
                  _buildFoodCard('Pasta', 'assets/images/Container1.png'),
                  _buildFoodCard('Burger', 'assets/images/Container1.png'),
                  _buildFoodCard('Sushi', 'assets/images/Container1.png'),
                  _buildFoodCard('Dumpling', 'assets/images/Container1.png'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build a tag
  Widget _buildTag(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.white,
      shape: StadiumBorder(
        side: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  // Helper function to build a food card
  Widget _buildFoodCard(String title, String imageUrl) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            imageUrl,
            height: 95,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
