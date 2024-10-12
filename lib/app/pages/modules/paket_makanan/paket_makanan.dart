import 'package:catering_mobile/app/components/drawer.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaketMakanan extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> paketMakananList = [
    {
      'image': 'assets/images/Container1.png',
      'name': 'Paket Sarapan (2-3 Orang)',
      'description': 'Nasi uduk, ayam goreng, dan sambal',
      'price': 'Rp 100.000',
      'rating': 4.5,
      'discount': 'Diskon 10%',
    },
    {
      'image': 'assets/images/Container1.png',
      'name': 'Paket Makan Siang (4-5 Orang)',
      'description': 'Nasi putih, rendang, dan lalapan',
      'price': 'Rp 250.000',
      'rating': 4.8,
      'discount': 'Diskon 15%',
    },
    {
      'image': 'assets/images/Container1.png',
      'name': 'Paket Makan Malam (6-8 Orang)',
      'description': 'Nasi goreng, telur, dan kerupuk',
      'price': 'Rp 360.000',
      'rating': 4.2,
      'discount': 'Diskon 5%',
    },
    {
      'image': 'assets/images/Container1.png',
      'name': 'Paket Spesial (9-10 Orang)',
      'description': 'Nasi kuning, ayam bakar, dan sambal',
      'price': 'Rp 500.000',
      'rating': 5.0,
      'discount': 'Diskon 20%',
    },
    {
      'image': 'assets/images/Container1.png',
      'name': 'Paket Minuman (2-10 Orang)',
      'description': 'Teh, kopi, dan air mineral',
      'price': 'Rp 70.000',
      'rating': 4.7,
      'discount': 'Diskon 5%',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final _selectedColor = Color(0xFFECD7D7);
    final _unselectedColor = Colors.white;
    final _selectedBackgroundColor = Color(0xFFFF3131);
    final _unselectedBackgroundColor = Color(0xFFECD7D7);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: _unselectedBackgroundColor,
        appBar: AppBar(
          backgroundColor: _unselectedBackgroundColor,
          elevation: 0,
          title: const Text(
            'Paket Makanan',
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
                                  Icon(Icons.wb_twilight, size: 18),
                                  SizedBox(width: 8),
                                  Text("Pagi"),
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
                                  Icon(Icons.wb_sunny, size: 18),
                                  SizedBox(width: 8),
                                  Text("Siang"),
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
                                  Icon(Icons.nights_stay, size: 18),
                                  SizedBox(width: 8),
                                  Text("Malam"),
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
                SizedBox(height: 8),
                Divider(),
              ],
            ),
          ),
        ),
        drawer: DrawerComponent(scaffoldKey: _scaffoldKey),
        body: TabBarView(
          children: [
            buildListView(),
            buildListView(),
            buildListView(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.CART);
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.shopping_cart, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildListView() {
    final _unselectedBackgroundColor = Color(0xFFECD7D7);
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: paketMakananList.length,
      itemBuilder: (context, index) {
        final paket = paketMakananList[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          color: _unselectedBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(paket['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paket['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(paket['description']),
                      SizedBox(height: 8),
                      Text(
                        paket['price'],
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          SizedBox(width: 5),
                          Text(
                            paket['rating'].toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              paket['discount'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
