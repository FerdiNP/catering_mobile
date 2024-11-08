import 'package:catering_mobile/app/components/drawer.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favorite extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get userId => _auth.currentUser?.uid ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        elevation: 0,
        title: const Text(
          'Menu Favorit Anda',
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
      ),
      drawer: DrawerComponent(scaffoldKey: _scaffoldKey),
      body: Container(
        color: Colors.pink[50],
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('users')
              .doc(userId)
              .collection('favorites') // Mengambil data favorit user
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('Tidak ada menu favorit.'));
            }

            var favoriteItems = snapshot.data!.docs;

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                var item = favoriteItems[index];
                var data = item.data() as Map<String, dynamic>;

                var isMenu = data.containsKey('menuId');
                var isPaket = data.containsKey('paketId');

                if (isMenu) {
                  var menuId = data['menuId'];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildFavoriteMenuItem(menuId),
                  );
                } else if (isPaket) {
                  var paketId = data['paketId'];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildFavoritePaketItem(paketId),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CART);
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }

  Widget _buildFavoriteMenuItem(String menuId) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('menus').doc(menuId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Menu tidak ditemukan.'));
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;
        var gambarMenu = data['gambarMenu'] ?? '';  // Correct the typo
        var namaMenu = data['namaMenu'] ?? 'No Title';
        var deskripsiMenu = data['deskripsiMenu'] ?? 'No Description';

        return MenuItem(
          image: gambarMenu,
          title: namaMenu,
          description: deskripsiMenu,
          onTap: () {
            Get.toNamed(Routes.DETAIL_MENU,
              arguments: {
                'namaMenu': data['namaMenu'] ?? 'Untitled',
                'deskripsiMenu': data['deskripsiMenu'] ?? 'No Description',
                'gambarMenu': data['gambarMenu'] ?? '',
                'hargaMenu': data['hargaMenu'] ?? 0,
                'menuId': menuId
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFavoritePaketItem(String paketId) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('packages').doc(paketId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Paket tidak ditemukan.'));
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;
        var gambarPaket = data['gambarPaket'] ?? '';
        var namaPaket = data['namaPaket'] ?? 'No Title';
        var deskripsiPaket = data['deskripsiPaket'] ?? 'No Description';

        return MenuItem(
          image: gambarPaket,
          title: namaPaket,
          description: deskripsiPaket,
          onTap: () {
            Get.toNamed(Routes.DETAIL_PAKET,
              arguments: {
                'namaPaket': data['namaPaket'] ?? 'Untitled',
                'deskripsiPaket': data['deskripsiPaket'] ?? 'No Description',
                'gambarPaket': data['gambarPaket'] ?? '',
                'hargaPaket': data['hargaPaket'] ?? 0,
                'paketId': paketId
              },
            );
          },
        );
      },
    );
  }
}

class MenuItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback onTap;

  const MenuItem({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                image.isNotEmpty ? image : 'https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/placeholder.png?alt=media&token=cb0b15db-a5cc-41fe-9739-66974e62c982',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/Container1.png',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
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
