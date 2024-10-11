import 'package:catering_mobile/app/components/drawer.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

const _mainColor = Color(0xFFECD7D7);

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Data makanan untuk setiap kategori
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

  @override
  Widget build(BuildContext context) {
    final _selectedColor = Color(0xFFECD7D7);
    final _unselectedColor = Colors.white;
    final _selectedBackgroundColor = Color(0xFFFF3131);
    final _unselectedBackgroundColor = Color(0xFFECD7D7);
    final _borderColor = Color(0xFFCDE7BE);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Color(0xFFECD7D7),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                'assets/images/logo.png',
                height: 20,
              ),
            ),
          ),
          backgroundColor: Color(0xFFECD7D7),
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
            preferredSize: Size.fromHeight(170),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          isScrollable: true,
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
                          tabAlignment: TabAlignment.start,
                          tabs: [
                            Tab(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.wb_twighlight, size: 18),
                                    SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        "Pagi",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.wb_sunny, size: 18),
                                    SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        "Siang",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.nights_stay, size: 18),
                                    SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        "Malam",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
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
                          Get.toNamed(Routes.SEARCH);
                        },
                      ),
                    ],
                  ),
                ),
                // ListView horizontal dengan gambar
                Container(
                  height: 100, // Tentukan tinggi
                  margin: EdgeInsets.only(top: 12), // Margin top untuk spasi
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3, // Jumlah item
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Container(
                              width: 192,
                              height: 96,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.greenAccent.withOpacity(0.2),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/Container1.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 4,),
                Divider(),
                SizedBox(height: 4,),
              ],
            ),
          ),
        ),
        drawer: DrawerComponent(scaffoldKey: _scaffoldKey), // Memanggil DrawerComponent
        body: TabBarView(
          children: [
            buildList(),
            buildList(),
            buildList(),
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
          "⭐ Populer",
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
  }}

