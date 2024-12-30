import 'package:catering_mobile/app/components/drawer.dart';
import 'package:catering_mobile/app/pages/modules/user/paket_makanan/controllers/paket_makanan_controller.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaketMakanan extends GetView<PaketMakananController> {
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
            buildListView('Pagi'),
            buildListView('Siang'),
            buildListView('Malam'),
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

  Widget buildListView(String waktu) {
    return Obx(() {
      if (controller.packageItems.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "⭐ Paket Makanan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            ListView.builder(
              shrinkWrap: true, // Added shrinkWrap to prevent overflow
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.packageItems.length,
              itemBuilder: (context, index) {
                return packageItem(controller.packageItems[index], waktu);
              },
            ),
          ],
        ),
      );
    });
  }

  Widget packageItem(Map<String, dynamic> item, String waktu) {
    String gambarPaket = item['gambarPaket'] ?? '';
    String namaPaket = item['namaPaket'] ?? 'Untitled';
    String deskripsiPaket = item['deskripsiPaket'] ?? 'No Description';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () async {
          if (!item.containsKey('idPaket') || item['idPaket'] == null || item['idPaket'].toString().isEmpty) {
            Get.snackbar(
              'Error',
              'Detail paket tidak tersedia. Please Wait',
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
            Get.offAllNamed(Routes.PAKET);
            return;
          }

          String paketId = item['idPaket'];

          try {
            var paketDetail = await FirebaseFirestore.instance
                .collection('packages')
                .doc(paketId)
                .get();

            if (!paketDetail.exists) {
              Get.snackbar(
                'Error',
                'Data paket tidak ditemukan',
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
              return;
            }

            var dataPaket = paketDetail.data() ?? {};

            Get.toNamed(
              Routes.DETAIL_PAKET,
              arguments: {
                'namaPaket': dataPaket['namaPaket'] ?? 'Untitled',
                'deskripsiPaket': dataPaket['deskripsiPaket'] ?? 'No Description',
                'gambarPaket': dataPaket['gambarPaket'] ?? '',
                'hargaPaket': dataPaket['hargaPaket'] ?? 0,
                'paketId': paketId
              },
            );
          } catch (e) {
            Get.snackbar(
              'Error',
              'Terjadi kesalahan saat mengambil data',
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
            print("Error saat mengambil data: $e");
          }
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: gambarPaket.isEmpty
                  ? Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/placeholder.png?alt=media&token=cb0b15db-a5cc-41fe-9739-66974e62c982',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover)
                  : Image.network(
                  gambarPaket,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaPaket,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    deskripsiPaket,
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
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.attach_money, size: 16, color: Colors.green),
                      Text(
                        item['hargaPaket'].toString(),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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