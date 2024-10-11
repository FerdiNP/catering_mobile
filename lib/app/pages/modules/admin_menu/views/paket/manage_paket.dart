import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagePaket extends StatelessWidget {
  final _backgroundColor = Color(0xFFECD7D7);

  final List<Map<String, String>> packageItems = [
    {
      'name': 'Paket Hemat 1',
      'price': 'Rp 50.000',
      'image': 'assets/images/Container1.png', // Ganti dengan URL gambar yang valid
    },
    {
      'name': 'Paket Kombo 2',
      'price': 'Rp 75.000',
      'image': 'assets/images/Container1.png', // Ganti dengan URL gambar yang valid
    },
    {
      'name': 'Paket Keluarga 3',
      'price': 'Rp 100.000',
      'image': 'assets/images/Container1.png', // Ganti dengan URL gambar yang valid
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        title: Text('Daftar Paket Makanan'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(Routes.FORMMENU); // Arahkan ke halaman tambah paket
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daftar Paket Makanan
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Paket Makanan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: packageItems.length,
              itemBuilder: (context, index) {
                final packageItem = packageItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: Image.asset(
                      packageItem['image']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(packageItem['name']!),
                    subtitle: Text(packageItem['price']!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Get.toNamed(Routes.FORMMENU); // Arahkan ke halaman edit paket
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
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
          content: Text('Apakah Anda yakin ingin menghapus paket ini?'),
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
                  SnackBar(content: Text('Paket telah dihapus')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
