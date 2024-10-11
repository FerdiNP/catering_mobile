import 'package:catering_mobile/app/components/drawer.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuMakanan extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, String>> foodItems = [
    {'title': 'Salad Omlat', 'description': 'Pagi, Sehat', 'discount': '30%', 'code': 'Kode PAGI 123', 'time': '20 min', 'price': '50.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Ayam Ceos', 'description': 'Pagi, Enak', 'discount': '20%', 'code': 'Kode PAGI 342', 'time': '15 min', 'price': '50.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Soto', 'description': 'Pagi, Enak', 'discount': '35%', 'code': 'Kode PAGI 6969', 'time': '10 min', 'price': '20.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Roti', 'description': 'Pagi, Enak, Murah', 'discount': '10%', 'code': 'Kode PAGI 389', 'time': '5 min', 'price': '10.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Nasi Goreng', 'description': 'Siang, Pedas', 'discount': '15%', 'code': 'Kode SIANG 456', 'time': '25 min', 'price': '30.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Mie Ayam', 'description': 'Siang, Lezat', 'discount': '5%', 'code': 'Kode SIANG 678', 'time': '12 min', 'price': '25.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Kwetiau', 'description': 'Siang, Gurih', 'discount': '20%', 'code': 'Kode SIANG 789', 'time': '10 min', 'price': '35.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Tahu Tempe', 'description': 'Malam, Sehat', 'discount': '25%', 'code': 'Kode MALAM 321', 'time': '15 min', 'price': '15.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Sushi', 'description': 'Malam, Unik', 'discount': '10%', 'code': 'Kode MALAM 654', 'time': '30 min', 'price': '45.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Pasta', 'description': 'Malam, Kenyang', 'discount': '5%', 'code': 'Kode MALAM 987', 'time': '20 min', 'price': '40.000', 'imagePath': 'assets/images/Container1.png'},
  ];

  // Daftar minuman menggunakan List<Map<String, String>>
  final List<Map<String, String>> drinkItems = [
    {'title': 'Jus Mangga', 'description': 'Segar dan Manis', 'discount': '10%', 'code': 'Kode JUS123', 'time': '5 min', 'price': '15.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Es Teh Manis', 'description': 'Dingin dan Segar', 'discount': '5%', 'code': 'Kode TEH456', 'time': '3 min', 'price': '5.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Kopi Latte', 'description': 'Hangat dan Kental', 'discount': '20%', 'code': 'Kode LATTE789', 'time': '7 min', 'price': '25.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Soda Gembira', 'description': 'Menyegarkan', 'discount': '15%', 'code': 'Kode SODA321', 'time': '5 min', 'price': '10.000', 'imagePath': 'assets/images/Container1.png'},
  ];

  // Daftar lainnya menggunakan List<Map<String, String>>
  final List<Map<String, String>> otherItems = [
    {'title': 'Cemilan Kentang', 'description': 'Renyah dan Gurih', 'discount': '10%', 'code': 'Kode CEMIL123', 'time': '10 min', 'price': '20.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Roti Bakar', 'description': 'Hangat dan Manis', 'discount': '15%', 'code': 'Kode ROTI456', 'time': '7 min', 'price': '15.000', 'imagePath': 'assets/images/Container1.png'},
    {'title': 'Martabak Manis', 'description': 'Lezat dan Mengenyangkan', 'discount': '20%', 'code': 'Kode MART789', 'time': '10 min', 'price': '25.000', 'imagePath': 'assets/images/Container1.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final _selectedColor = Color(0xFFECD7D7);
    final _unselectedColor = Colors.white;
    final _selectedBackgroundColor = Color(0xFFFF3131);
    final _unselectedBackgroundColor = Color(0xFFECD7D7);
    return DefaultTabController(
      length: 3, // Jumlah kategori (Makanan, Minuman, Lainnya)
      child: Scaffold(
        backgroundColor: Color(0xFFECD7D7),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Color(0xFFECD7D7),
          elevation: 0,
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TabBar(
                        isScrollable: false,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: _selectedBackgroundColor,
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: _selectedColor,
                        unselectedLabelColor: Colors.black,
                        unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: [
                          Tab(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.food_bank, size: 18),
                                  SizedBox(width: 8),
                                  Text("Makanan"),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.local_drink, size: 18),
                                  SizedBox(width: 8),
                                  Text("Minuman"),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.more, size: 18),
                                  SizedBox(width: 8),
                                  Text("Lainnya"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        // Menavigasi ke halaman pencarian
                        Get.toNamed(Routes.SEARCH); // Ganti dengan rute pencarian yang sesuai
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Divider(),              ],
            ),
          ),
        ),
        drawer: DrawerComponent(scaffoldKey: _scaffoldKey), // Memanggil DrawerComponent
        body: TabBarView(
          children: [
            // Konten untuk tab "Makanan"
            buildList(),
            // Konten untuk tab "Minuman"
            buildDrinkList(),
            // Konten untuk tab "Lainnya"
            buildOtherList(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Arahkan ke halaman keranjang
            Get.toNamed(Routes.CART);
          },
          backgroundColor: Colors.red, // Ubah warna background tombol
          child: Icon(Icons.shopping_cart, color: Colors.white), // Ikon keranjang
        ),
      ),

    );
  }

  Widget buildList() {
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
        ...foodItems.map((item) => foodItem(item)).toList(),
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
        ...drinkItems.map((item) => foodItem(item)).toList(),
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
        ...otherItems.map((item) => foodItem(item)).toList(),
      ],
    );
  }

  // Food Item Widget
  Widget foodItem(Map<String, String> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              item['imagePath']!,
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
                  item['title']!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(item['description']!,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.discount, size: 16, color: Colors.orange),
                    SizedBox(width: 5),
                    Text("${item['discount']} | ${item['code']}", style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(
                      item['time']!,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.attach_money, size: 16, color: Colors.green),
                    SizedBox(width: 5),
                    Text(
                      item['price']!,
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
