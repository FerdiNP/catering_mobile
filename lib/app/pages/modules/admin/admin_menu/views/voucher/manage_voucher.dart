import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageVoucher extends StatefulWidget {
  @override
  _ManageVoucherState createState() => _ManageVoucherState();
}

class _ManageVoucherState  extends State<ManageVoucher> {

  final Color _backgroundColor = Color(0xFFECD7D7);
  final CollectionReference _voucherCollection = FirebaseFirestore.instance.collection('vouchers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        title: Text('Daftar Voucher Makanan'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(Routes.FORMVOUCHER);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _voucherCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final voucherItems = snapshot.data!.docs;


          return ListView.builder(
            itemCount: voucherItems.length,
            itemBuilder: (context, index) {
              final voucher = voucherItems[index];
              final voucherId = voucher.id; // Accessing the document ID correctly

              String kodeVoucher = voucher['kodeVoucher'] ?? 'Kode Voucher Tidak Diketahui';
              String diskonVoucher = '${voucher.get('diskonVoucher')?.toString() ?? '0'}%';
              String deskripsiVoucher = voucher['deskripsiVoucher'] ?? 'Deskripsi Tidak Diketahui'; // Ganti dengan URL default jika gambar null

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  title: Text(kodeVoucher),
                  subtitle: Text('Diskon: ${diskonVoucher}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Arahkan ke halaman edit dengan ID menu
                          Get.toNamed(Routes.FORMVOUCHER, arguments: {
                            'voucherId': voucherId,
                            'kodeVoucher': voucher['kodeVoucher'],
                            'diskonVoucher': voucher['diskonVoucher'],
                            'deskripsiVoucher': voucher['deskripsiVoucher'],
                            'statusVoucher': voucher['status'],
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, voucherItems[index].id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String voucherId) {
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
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () async {
                // Hapus data dari Firestore
                await FirebaseFirestore.instance.collection('vouchers').doc(voucherId).delete();
                Navigator.of(context).pop();
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
