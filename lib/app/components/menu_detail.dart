import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailMenuPage extends StatefulWidget {
  @override
  _DetailMenuPageState createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  final _mainColor = Color(0xFFECD7D7);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var menuData = Get.arguments;

  String menuId = '';
  String namaMenu = 'Untitled';
  String deskripsiMenu = 'No Description';
  String gambarMenu = '';
  int hargaMenu = 0;

  RxInt jumlahItem = 1.obs;
  RxBool isFavorite = false.obs;

  late String userId;

  @override
  void initState() {
    super.initState();

    if (menuData != null) {
      menuId = menuData['menuId'] ?? '';
      namaMenu = menuData['namaMenu'] ?? 'Untitled';
      deskripsiMenu = menuData['deskripsiMenu'] ?? 'No Description';
      gambarMenu = menuData['gambarMenu'] ?? '';
      hargaMenu = menuData['hargaMenu'] ?? 0;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkFavoriteStatus();
    });

    User? user = _auth.currentUser;
    if (user != null) {
      userId = user.uid;
    } else {
      print("User belum login");
    }
  }

  Future<void> checkFavoriteStatus() async {
    final user = _auth.currentUser;
    userId = user!.uid; // Ambil user ID

    try {
      // Cek apakah menuId ada di koleksi favorit
      var docSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(menuId) // Cek berdasarkan menuId
          .get();

      if (docSnapshot.exists) {
        setState(() {
          isFavorite.value = docSnapshot['isFavorite'] ?? false;
        });
      } else {
        setState(() {
          isFavorite.value = false; // Jika belum ada di favorit
        });
      }
    } catch (e) {
      print("Error checking favorite status: $e");
      setState(() {
        isFavorite.value = false; // Default jika gagal memeriksa status favorit
      });
    }
  }

  Future<void> saveFavoriteStatus(bool isFav) async {
    final user = _auth.currentUser;
    userId = user!.uid;
    try {
      if (isFav) {
        // Menambahkan ke favorit
        await _firestore.collection('users').doc(userId).collection('favorites').doc(menuId).set({
          'menuId': menuId,
          'isFavorite': isFav,
        });
      } else {
        // Menghapus dari favorit
        await _firestore.collection('users').doc(userId).collection('favorites').doc(menuId).delete();
      }

      setState(() {
        isFavorite.value = isFav; // Perbarui status favorit
      });

      Get.snackbar(
        isFav ? "Menambahkan ke Favorit" : "Menghapus dari Favorit",
        "Menu berhasil ${isFav ? 'ditambahkan' : 'dihapus'} dari favorit.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: isFav ? Colors.blue : Colors.red,
        colorText: Colors.white,
        duration: Duration(milliseconds: 1000),
        margin: EdgeInsets.all(20),
      );
    } catch (e) {
      print("Error saving favorite status: $e");
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat menyimpan status favorit.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(milliseconds: 1000),
      );
    }
  }

  void clear() {
    menuData.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _mainColor,
      appBar: AppBar(
        title: Text(namaMenu, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: _mainColor,
        actions: [
          // Tombol favorit di sebelah kanan
          Obx(() => IconButton(
            icon: Icon(
                isFavorite.value ? Icons.favorite : Icons.favorite_border,
                color: isFavorite.value ? Colors.red : Colors.black
            ),
            onPressed: () {
              // Toggle status favorit
              isFavorite.value = !isFavorite.value;

              // Menyimpan status favorit ke Firestore
              saveFavoriteStatus(isFavorite.value);
            },
          )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: gambarMenu.isEmpty
                  ? Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/placeholder.png?alt=media&token=cb0b15db-a5cc-41fe-9739-66974e62c982',
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover)
                  : Image.network(gambarMenu,
                      width: double.infinity, height: 250, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  namaMenu,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Spacer(),
                Text(
                  '${NumberFormat('#,###', 'id_ID').format(hargaMenu)}',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              deskripsiMenu,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 70),
            // Counter untuk jumlah
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFF3131),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.2),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: _mainColor),
                        onPressed: () {
                          if (jumlahItem.value > 1) {
                            jumlahItem.value--;
                          }
                        },
                      ),
                      Obx(() => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              '${jumlahItem.value}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: _mainColor,
                              ),
                            ),
                          )),
                      IconButton(
                        icon: Icon(Icons.add, color: _mainColor),
                        onPressed: () {
                          jumlahItem.value++;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFFF3131),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: () {
              Get.snackbar(
                "Menu Berhasil Ditambahkan",
                "Menu ${namaMenu} berhasil ditambahkan ke keranjang.",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: Duration(milliseconds: 1000),
                margin: EdgeInsets.all(20),
              );

              clear();

              Navigator.of(context).pop();
            },
            child: Text(
              'Tambah ke Keranjang',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
