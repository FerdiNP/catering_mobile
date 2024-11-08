import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagePaket extends StatefulWidget {
  @override
  _ManagePaketState createState() => _ManagePaketState();
}

class _ManagePaketState  extends State<ManagePaket> {

  final Color _backgroundColor = Color(0xFFECD7D7);
  final CollectionReference _packageCollection = FirebaseFirestore.instance.collection('packages');

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
              Get.toNamed(Routes.FORMPAKET);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _packageCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final packageItems = snapshot.data!.docs;

          return ListView.builder(
            itemCount: packageItems.length,
            itemBuilder: (context, index) {
              final package = packageItems[index];
              final packageId = package.id; // Accessing the document ID correctly

              String namaPaket = package['namaPaket'] ?? 'Menu Tidak Diketahui';
              String hargaPaket = 'Rp ${package['hargaPaket'] ?? '0'}';
              String gambarPaket = package['gambarPaket'] ?? 'https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/placeholder.png?alt=media&token=cb0b15db-a5cc-41fe-9739-66974e62c982'; // Ganti dengan URL default jika gambar null

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: Image.network(
                    gambarPaket,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(namaPaket),
                  subtitle: Text(hargaPaket),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Arahkan ke halaman edit dengan ID menu
                          Get.toNamed(Routes.FORMMENU, arguments: {
                            'packageId': packageId,
                            'namaPaket': package['namaPaket'],
                            'deskripsiPaket': package['deskripsiPaket'],
                            'hargaPaket': package['hargaPaket'],
                            'statusPaket': package['status'],
                            'gambarPaket': package['gambarPaket'],
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, packageItems[index].id);
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

  void _showDeleteConfirmationDialog(BuildContext context, String packageId) {
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
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () async {
                // Hapus data dari Firestore
                await FirebaseFirestore.instance.collection('packages').doc(packageId).delete();
                Navigator.of(context).pop();
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
