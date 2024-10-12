import 'package:catering_mobile/app/components/drawer.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favorite extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        elevation: 0,
        title: const Text(
          'Menu Favorit Anda',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/1.png'),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      drawer: DrawerComponent(scaffoldKey: _scaffoldKey),
      body: Container(
        color: Colors.pink[50],
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            MenuItem(
              image: 'assets/images/Container1.png',
              title: 'Nasi Goreng Seafood',
              description:
              'Merupakan olahan nasi goreng dan ada campuran seafood seperti udang yang menciptakan rasa mewah di dalamnya.',
            ),
            const SizedBox(height: 16),
            MenuItem(
              image: 'assets/images/Container1.png',
              title: 'Soto Ayam',
              description:
              'Merupakan olahan campuran bihun, ayam, telur, toge, yang disajikan dengan kuah kaldu yang lezat, dapat ditambah dengan telur dan perasan jeruk nipis.',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CART);
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const MenuItem({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.asset(
              image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
