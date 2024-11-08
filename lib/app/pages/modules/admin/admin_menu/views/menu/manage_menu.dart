import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageMenu extends StatefulWidget {
  @override
  _ManageMenuState createState() => _ManageMenuState();
}

class _ManageMenuState  extends State<ManageMenu> {

  final Color _backgroundColor = Color(0xFFECD7D7);
  final CollectionReference _menuCollection = FirebaseFirestore.instance.collection('menus');

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
              Get.toNamed(Routes.FORMMENU);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _menuCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final menuItems = snapshot.data!.docs;

          return ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final menu = menuItems[index];
              final menuId = menu.id; // Accessing the document ID correctly

              String namaMenu = menu['namaMenu'] ?? 'Menu Tidak Diketahui';
              String hargaMenu = 'Rp ${menu['hargaMenu'] ?? '0'}';
              String gambarMenu = menu['gambarMenu'] ?? 'https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/placeholder.png?alt=media&token=cb0b15db-a5cc-41fe-9739-66974e62c982'; // Ganti dengan URL default jika gambar null

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: Image.network(
                    gambarMenu,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(namaMenu),
                  subtitle: Text(hargaMenu),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Arahkan ke halaman edit dengan ID menu
                          Get.toNamed(Routes.FORMMENU, arguments: {
                            'menuId': menuId,
                            'namaMenu': menu['namaMenu'],
                            'deskripsiMenu': menu['deskripsiMenu'],
                            'hargaMenu': menu['hargaMenu'],
                            'statusMenu': menu['status'],
                            'gambarMenu': menu['gambarMenu'],
                          });
                         },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, menuItems[index].id);
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

  void _showDeleteConfirmationDialog(BuildContext context, String menuId) {
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
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () async {
                // Hapus data dari Firestore
                await FirebaseFirestore.instance.collection('menus').doc(menuId).delete();
                Navigator.of(context).pop();
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
