import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageMenu extends StatelessWidget {
  final _backgroundColor = Color(0xFFECD7D7);
  final List<Map<String, String>> menuItems = [
    {
      'name': 'Nasi Goreng',
      'price': 'Rp 20.000',
      'image': 'assets/images/Container1.png', // Ganti dengan URL gambar yang valid
    },
    {
      'name': 'Sate Ayam',
      'price': 'Rp 25.000',
      'image': 'assets/images/Container1.png', // Ganti dengan URL gambar yang valid
    },
    {
      'name': 'Mie Goreng',
      'price': 'Rp 18.000',
      'image': 'assets/images/Container1.png', // Ganti dengan URL gambar yang valid
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        title: Text('Daftar Menu Makanan'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(Routes.FORMMENU); // Arahkan ke halaman tambah menu
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final menuItem = menuItems[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: EdgeInsets.all(8),
              leading: Image.asset(
                menuItem['image']!, // Mengambil gambar dari URL
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(menuItem['name']!),
              subtitle: Text(menuItem['price']!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Get.toNamed(Routes.FORMMENU); // Arahkan ke halaman edit menu
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Tampilkan dialog konfirmasi untuk penghapusan
                      _showDeleteConfirmationDialog(context, index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Metode untuk menampilkan dialog konfirmasi
  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus menu ini?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Menu telah dihapus')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
