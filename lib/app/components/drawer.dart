// lib/components/drawer_component.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart'; // Pastikan jalur import ini sesuai

class DrawerComponent extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DrawerComponent({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> menuItems = <String>[
      'Home',
      'Menu Makanan',
      'Paket Makanan',
      'Favorit',
    ];

    final List<String> menuRoutes = <String>[
      Routes.HOME,          // Route untuk halaman Home
      Routes.MENU,      // Route untuk halaman Menu Makanan
      Routes.PAKET,      // Route untuk halaman Paket Makanan
      Routes.FAVORITE,      // Route untuk halaman Favorit
    ];

    final List<IconData> menuIcons = <IconData>[
      Icons.home,            // Ikon untuk Home
      Icons.restaurant_menu,  // Ikon untuk Menu Makanan
      Icons.card_giftcard,     // Ikon untuk Paket Makanan
      Icons.favorite,         // Ikon untuk Favorit
    ];

    return Drawer(
      backgroundColor: const Color(0xFFECD7D7), // Mengubah warna background Drawer
      child: Column(
        children: [
          // Menambahkan gambar logo di atas ListTile
          Padding(
            padding: const EdgeInsets.only(top: 20.0), // Mengurangi jarak logo dengan menu
            child: Image.asset(
              'assets/images/logo.png', // Path gambar logo
              height: 100, // Memperbesar tinggi logo
              width: 120, // Memperbesar lebar logo
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                // Cek apakah rute saat ini sama dengan rute item yang ditekan
                bool isActive = Get.currentRoute == menuRoutes[index];

                return ListTile(
                  leading: Icon(
                    menuIcons[index], // Menambahkan ikon untuk setiap item
                    color: isActive ? const Color(0xFFECD7D7) : Colors.black, // Ubah warna ikon sesuai status aktif
                  ),
                  onTap: () {
                    if (!isActive) {
                      scaffoldKey.currentState?.openEndDrawer();
                      Navigator.of(context).pop(); // Menutup Drawer
                      Get.offNamed(menuRoutes[index]); // Navigasi ke halaman sesuai item
                    } else {
                      scaffoldKey.currentState?.openEndDrawer();
                      Navigator.of(context).pop(); // Menutup Drawer jika sudah di halaman yang sama
                    }
                  },
                  title: Text(
                    menuItems[index],
                    style: TextStyle(
                      color: isActive ? const Color(0xFFECD7D7) : Colors.black, // Warna teks berbeda saat aktif
                      fontWeight: isActive ? FontWeight.w900 : FontWeight.bold, // Tebal font lebih besar saat aktif
                      fontSize: 16, // Ukuran font tetap
                    ),
                  ),
                  tileColor: isActive ? const Color(0xFFFF3131) : null, // Latar belakang berbeda saat aktif
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
