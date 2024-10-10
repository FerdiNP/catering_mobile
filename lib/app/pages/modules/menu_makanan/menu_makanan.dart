import 'package:catering_mobile/app/components/drawer.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuMakanan extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Jumlah kategori (Makanan, Minuman, Lainnya)
      child: Scaffold(
        backgroundColor: Color(0xFFECD7D7),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Color(0xFFECD7D7), // Tetap statis, tidak berubah
          elevation: 0, // Elevasi tetap 0 untuk membuatnya flat
          title: const Text(
            'Menu Makanan',
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
                  // Menampilkan drawer
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            GestureDetector(
              onTap: () {
                // Menavigasi ke halaman profil
                Get.toNamed(Routes.PROFILE);
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/1.png'),
              ),
            ),
            SizedBox(width: 16),
          ],
          bottom: TabBar(
            indicatorColor: Colors.black, // Warna indikator tab
            labelColor: Colors.black, // Warna teks aktif
            unselectedLabelColor: Colors.grey, // Warna teks tidak aktif
            tabs: [
              Tab(text: 'Makanan'),
              Tab(text: 'Minuman'),
              Tab(text: 'Lainnya'),
            ],
          ),
        ),
        drawer: DrawerComponent(scaffoldKey: _scaffoldKey), // Memanggil DrawerComponent
        body: TabBarView(
          children: [
            // Konten untuk tab "Makanan"
            buildFoodList(),
            // Konten untuk tab "Minuman"
            buildDrinkList(),
            // Konten untuk tab "Lainnya"
            buildOtherList(),
          ],
        ),
      ),
    );
  }

  // Widget untuk list Makanan
  Widget buildFoodList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        SizedBox(height: 20),
        Text(
          "⭐ Makanan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20),
        foodItem(
            'Salad Omlat',
            'Pagi, Sehat',
            '30%',
            'Kode PAGI 123',
            '20 min',
            '50.000',
            'assets/images/Container1.png'),
        foodItem(
            'Ayam Ceos',
            'Pagi, Enak',
            '20%',
            'Kode PAGI 342',
            '15 min',
            '50.000',
            'assets/images/Container1.png'),
        foodItem(
            'Soto', 'Pagi, Enak', '35%', 'Kode PAGI 6969', '10 min', '20.000', 'assets/images/Container1.png'),
        foodItem(
            'Roti',
            'Pagi, Enak, Murah',
            '10%',
            'Kode PAGI 389',
            '5 min',
            '10.000',
            'assets/images/Container1.png'),
        foodItem(
            'Nasi Goreng',
            'Siang, Pedas',
            '15%',
            'Kode SIANG 456',
            '25 min',
            '30.000',
            'assets/images/Container1.png'),
        foodItem(
            'Mie Ayam',
            'Siang, Lezat',
            '5%',
            'Kode SIANG 678',
            '12 min',
            '25.000',
            'assets/images/Container1.png'),
        foodItem(
            'Kwetiau',
            'Siang, Gurih',
            '20%',
            'Kode SIANG 789',
            '10 min',
            '35.000',
            'assets/images/Container1.png'),
        foodItem(
            'Tahu Tempe',
            'Malam, Sehat',
            '25%',
            'Kode MALAM 321',
            '15 min',
            '15.000',
            'assets/images/Container1.png'),
        foodItem(
            'Sushi',
            'Malam, Unik',
            '10%',
            'Kode MALAM 654',
            '30 min',
            '45.000',
            'assets/images/Container1.png'),
        foodItem(
            'Pasta',
            'Malam, Kenyang',
            '5%',
            'Kode MALAM 987',
            '20 min',
            '40.000',
            'assets/images/Container1.png'),
      ],
    );
  }

  // Widget untuk list Minuman
  Widget buildDrinkList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        SizedBox(height: 20),
        Text(
          "🍹 Minuman",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20),
        foodItem(
            'Jus Mangga',
            'Segar dan Manis',
            '10%',
            'Kode JUS123',
            '5 min',
            '15.000',
            'assets/images/Container1.png'),
        foodItem(
            'Es Teh Manis',
            'Dingin dan Segar',
            '5%',
            'Kode TEH456',
            '3 min',
            '5.000',
            'assets/images/Container1.png'),
        foodItem(
            'Kopi Latte',
            'Hangat dan Kental',
            '20%',
            'Kode LATTE789',
            '7 min',
            '25.000',
            'assets/images/Container1.png'),
        foodItem(
            'Soda Gembira',
            'Menyegarkan',
            '15%',
            'Kode SODA321',
            '5 min',
            '10.000',
            'assets/images/Container1.png'),
      ],
    );
  }

  // Widget untuk list Lainnya
  Widget buildOtherList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        SizedBox(height: 20),
        Text(
          "🍲 Lainnya",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20),
        foodItem(
            'Cemilan Kentang',
            'Renyah dan Gurih',
            '10%',
            'Kode CEMIL123',
            '10 min',
            '20.000',
            'assets/images/Container1.png'),
        foodItem(
            'Roti Bakar',
            'Hangat dan Manis',
            '15%',
            'Kode ROTI456',
            '7 min',
            '15.000',
            'assets/images/Container1.png'),
        foodItem(
            'Martabak Manis',
            'Lezat dan Mengenyangkan',
            '20%',
            'Kode MART789',
            '10 min',
            '25.000',
            'assets/images/Container1.png'),
      ],
    );
  }

  // Food Item Widget
  Widget foodItem(String title, String description, String discount,
      String code, String time, String price, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(description,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.discount, size: 16, color: Colors.orange),
                    SizedBox(width: 5),
                    Text("$discount | $code", style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(
                      time,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.attach_money, size: 16, color: Colors.green),
                    SizedBox(width: 5),
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
