import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageVoucher extends StatelessWidget {
  final _selectedColor = Color(0xFFECD7D7);
  final _unselectedColor = Colors.white;
  final _selectedBackgroundColor = Color(0xFFFF3131);
  final _unselectedBackgroundColor = Color(0xFFECD7D7);
  final _borderColor = Color(0xFFCDE7BE);

  // Dummy data voucher
  final List<Map<String, String>> vouchers = [
    {'code': 'DISC10', 'discount': '10%'},
    {'code': 'DISC20', 'discount': '20%'},
    {'code': 'DISC50', 'discount': '50%'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _unselectedBackgroundColor,
      appBar: AppBar(
        backgroundColor: _unselectedBackgroundColor,
        title: Text('Daftar Voucher'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(Routes.FORMVOUCHER); // Arahkan ke halaman tambah voucher
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          final voucher = vouchers[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(voucher['code']!), // Menampilkan kode voucher
              subtitle: Text('Diskon: ${voucher['discount']}'), // Menampilkan diskon
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Get.toNamed(Routes.FORMVOUCHER); // Arahkan ke halaman edit voucher
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
          content: Text('Apakah Anda yakin ingin menghapus voucher ini?'),
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
                  SnackBar(content: Text('Voucher telah dihapus')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}