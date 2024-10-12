import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0E1E1),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Mau makan apa hari ini?',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),

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

              Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),

              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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

  Widget _buildTag(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.white,
      shape: StadiumBorder(
        side: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

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
