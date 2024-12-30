import 'package:catering_mobile/app/components/drawer.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/menu_makanan_controller.dart';

class MenuMakanan extends GetView<MenuMakananController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _selectedColor = Color(0xFFECD7D7);
    final _unselectedColor = Colors.white;
    final _selectedBackgroundColor = Color(0xFFFF3131);
    final _unselectedBackgroundColor = Color(0xFFECD7D7);

    return DefaultTabController(
      length: 3,
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
            foodList(),
            drinkList(),
            otherList(),
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

  Widget foodList() {
    return Obx(() {
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
          ...controller.foodItems.map((item) => foodItem(item)).toList(),
        ],
      );
    });
  }

  Widget drinkList() {
    return Obx(() {
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
          ...controller.drinkItems.map((item) => foodItem(item)).toList(),
        ],
      );
    });
  }

  Widget otherList() {
    return Obx(() {
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
          ...controller.otherItems.map((item) => foodItem(item)).toList(),
        ],
      );
    });
  }

  Widget foodItem(Map<String, dynamic> item) {
    String gambarMenu = item['gambarMenu'] ?? '';
    String namaMenu = item['namaMenu'] ?? 'Untitled';
    String deskripsiMenu = item['deskripsiMenu'] ?? 'No Description';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () async {
          if (!item.containsKey('idMenu') || item['idMenu'] == null) {
            print("Field idMenu tidak ditemukan pada item ini: $item");
            return;
          }

          String menuId = item['idMenu'];

          try {
            var menuDetail = await FirebaseFirestore.instance
                .collection('menus')
                .doc(menuId)
                .get();

            if (!menuDetail.exists) {
              print("Document with id $menuId not found in Firestore.");
              return;
            }

            var dataMenu = menuDetail.data() ?? {};

            print("Navigating to DETAIL_MENU with arguments: $dataMenu");

            Get.toNamed(
              Routes.DETAIL_MENU,
              arguments: {
                'namaMenu': dataMenu['namaMenu'] ?? 'Untitled',
                'deskripsiMenu': dataMenu['deskripsiMenu'] ?? 'No Description',
                'gambarMenu': dataMenu['gambarMenu'] ?? '',
                'hargaMenu': dataMenu['hargaMenu'] ?? 0,
                'menuId': menuId,
              },
            );
          } catch (e) {
            print("Error saat mengambil data: $e");
          }
        }
,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: gambarMenu.isEmpty
                  ? Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/placeholder.png?alt=media&token=cb0b15db-a5cc-41fe-9739-66974e62c982',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover)
                  : Image.network(gambarMenu,
                      width: 100, height: 100, fit: BoxFit.cover),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaMenu,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    deskripsiMenu,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.discount, size: 16, color: Colors.orange),
                      SizedBox(width: 5),
                      Text("50% | DISC50", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 16, color: Colors.green),
                      Text(
                        item['hargaMenu'].toString(),
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
      ),
    );
  }
}
