import 'package:catering_mobile/app/components/drawer.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

const _mainColor = Color(0xFFECD7D7);

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                Container(
                  height: 100,
                  margin: EdgeInsets.only(top: 12),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
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
                SizedBox(
                  height: 4,
                ),
                Divider(),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
        drawer: DrawerComponent(scaffoldKey: _scaffoldKey),
        body: TabBarView(
          children: [
            buildList('Pagi'),
            buildList('Siang'),
            buildList('Malam'),
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

  Widget buildList(String waktu) {
    return Obx(() {
      if (controller.foodItems.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.foodItems.length,
              itemBuilder: (context, index) {
                return foodItem(controller.foodItems[index], waktu);
              },
            ),
          ],
        ),
      );
    });
  }

  Widget foodItem(Map<String, dynamic> item, String waktu) {
    String gambarMenu = item['gambarMenu'] ?? '';
    String namaMenu = item['namaMenu'] ?? 'Untitled';
    String deskripsiMenu = item['deskripsiMenu'] ?? 'No Description';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () async {
          if (!item.containsKey('idMenu') || item['idMenu'] == null || item['idPaket'].toString().isEmpty) {
            Get.snackbar(
              'Error',
              'Detail menu tidak tersedia. Please Wait',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(10),
              borderRadius: 10,
              icon: Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
            );
            print("error");
            Get.offAllNamed(Routes.MENU);
            Get.offAllNamed(Routes.HOME);
            return;
          }

          String menuId = item['idMenu'] as String;
          try {
            var menuDetail = await FirebaseFirestore.instance
                .collection('menus')
                .doc(menuId)
                .get();

            var dataMenu = menuDetail.data() ?? {};

            Get.toNamed(
              Routes.DETAIL_MENU,
              arguments: {
                'namaMenu': dataMenu['namaMenu'] ?? 'Untitled',
                'deskripsiMenu': dataMenu['deskripsiMenu'] ?? 'No Description',
                'gambarMenu': dataMenu['gambarMenu'] ?? '',
                'hargaMenu': dataMenu['hargaMenu'] ?? 0,
                'menuId': menuId
              },
            );
          } catch (e) {
            print("Error saat mengambil data: $e");
          }
        },
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
                      Icon(Icons.access_time, size: 16, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(
                        waktu,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
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
