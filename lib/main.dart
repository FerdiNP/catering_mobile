import 'package:catering_mobile/app/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> tambahBanyakData(List<Map<String, dynamic>> daftarData) async {
  final WriteBatch batch = FirebaseFirestore.instance.batch();
  final CollectionReference datas = FirebaseFirestore.instance.collection('packages');

  try {
    for (var data in daftarData) {
      final docRef = datas.doc(); // Membuat referensi dokumen baru secara otomatis
      batch.set(docRef, data); // Menambahkan setiap dokumen ke batch
    }

    await batch.commit(); // Eksekusi semua operasi batch
    print("Batch data berhasil ditambahkan!");
  } catch (e) {
    print("Error saat menambahkan batch data: $e");
  }
}

void main() async {
  List<Map<String, dynamic>> daftarData = [
    {
      "createdAt": Timestamp.fromDate(DateTime(2024, 11, 06, 14, 00, 00)),
      "deskripsiPaket": "Nikmati Paket Hemat 1 yang terdiri dari 1 Nasi Goreng Spesial, 1 Jus Jeruk Segar, dan 1 Kue Cubir sebagai snack.",
      "gambarPaket": "https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/Container%20(1).png?alt=media&token=1ec6ca47-5ebb-4122-96d6-186ab6027de0",
      "hargaPaket": 25000,
      "namaPaket": "Paket Hemat 1",
      "status": "available",
    },
    {
      "createdAt": Timestamp.fromDate(DateTime(2024, 11, 06, 14, 00, 00)),
      "deskripsiPaket": "Paket Hemat 2 ini berisi 1 Nasi Kuning, 1 Teh Manis Hangat, dan 1 Donat Coklat sebagai snack.",
      "gambarPaket": "https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/Container%20(2).png?alt=media&token=2ab6cc13-8e72-460b-bd64-23d37a4b32fc",
      "hargaPaket": 30000,
      "namaPaket": "Paket Hemat 2",
      "status": "available",
    },
    {
      "createdAt": Timestamp.fromDate(DateTime(2024, 11, 06, 14, 00, 00)),
      "deskripsiPaket": "Paket Hemat 3 menyajikan 1 Mie Goreng Pedas, 1 Es Teh Manis, dan 1 Pisang Goreng sebagai teman santap.",
      "gambarPaket": "https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/Container%20.png?alt=media&token=3bcb8ca8-b2c2-4757-8eb1-9cf6fd7cbecc",
      "hargaPaket": 27000,
      "namaPaket": "Paket Hemat 3",
      "status": "available",
    },
    {
      "createdAt": Timestamp.fromDate(DateTime(2024, 11, 06, 14, 00, 00)),
      "deskripsiPaket": "Cicipi Paket Hemat 4 yang terdiri dari 1 Burger Daging Sapi, 1 Soda Gembira, dan 1 Brownie Coklat sebagai cemilan.",
      "gambarPaket": "https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/Container%20.png?alt=media&token=72f3b9f5-4ad6-4f42-8b60-6d1d2875d8a9",
      "hargaPaket": 35000,
      "namaPaket": "Paket Hemat 4",
      "status": "available",
    },
    {
      "createdAt": Timestamp.fromDate(DateTime(2024, 11, 06, 14, 00, 00)),
      "deskripsiPaket": "Paket Hemat 5 menawarkan 1 Salad Buah, 1 Air Mineral, dan 1 Roti Bakar sebagai pendamping.",
      "gambarPaket": "https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/Container%20.png?alt=media&token=5f0ac3d2-931b-46d5-8f2a-2688c357b11d",
      "hargaPaket": 22000,
      "namaPaket": "Paket Hemat 5",
      "status": "available",
    },
    {
      "createdAt": Timestamp.fromDate(DateTime(2024, 11, 06, 14, 00, 00)),
      "deskripsiPaket": "Paket Cepat 1 cocok untuk yang sibuk, berisi 1 Roti Lapis, 1 Kopi Susu, dan 1 Keripik Kentang.",
      "gambarPaket": "https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/Container%20.png?alt=media&token=36b23a85-e070-4e2d-a478-d40ef1ab2c3b",
      "hargaPaket": 14000,
      "namaPaket": "Paket Cepat 1",
      "status": "available",
    },
    {
      "createdAt": Timestamp.fromDate(DateTime(2024, 11, 06, 14, 00, 00)),
      "deskripsiPaket": "Paket Mantap 1 terdiri dari 1 Sate Ayam, 1 Teh Hijau, dan 1 Kue Cubir.",
      "gambarPaket": "https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/Container%20.png?alt=media&token=0bff3a25-98fd-402d-ae69-3b5d6a93fe84",
      "hargaPaket": 24000,
      "namaPaket": "Paket Mantap 2",
      "status": "available",
    },
    {
      "createdAt": Timestamp.fromDate(DateTime(2024, 11, 06, 14, 00, 00)),
      "deskripsiPaket": "Paket Mantap 3 berisi 1 Nasi Padang, 1 Air Kelapa Muda, dan 1 Kue Lapis Surabaya.",
      "gambarPaket": "https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/Container%20.png?alt=media&token=6f5b8015-997f-44b0-b679-d460be104b1f",
      "hargaPaket": 32000,
      "namaPaket": "Paket Mantap 3",
      "status": "available",
    },
    {
      "createdAt": Timestamp.fromDate(DateTime(2024, 11, 06, 14, 00, 00)),
      "deskripsiPaket": "Paket Enak 1 menawarkan 1 Nasi Campur, 1 Jus Mangga, dan 1 Kue Cubir.",
      "gambarPaket": "https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/Container%20.png?alt=media&token=2f97094e-9c92-4938-b1bc-cf20fbb64a31",
      "hargaPaket": 30000,
      "namaPaket": "Paket Enak 1",
      "status": "available",
    },
    {
      "createdAt": Timestamp.fromDate(DateTime(2024, 11, 06, 14, 00, 00)),
      "deskripsiPaket": "Paket Enak 2 terdiri dari 1 Nasi Goreng Kampung, 1 Jus Alpukat, dan 1 Keripik Singkong.",
      "gambarPaket": "https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/Container%20.png?alt=media&token=25e72391-d7c1-4f3e-b57e-23c1e5f73999",
      "hargaPaket": 35000,
      "namaPaket": "Paket Enak 2",
      "status": "available",
    },
  ];


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  // await FirebaseMessagingHandler().initPushNotification();
  // await FirebaseMessagingHandler().initLocalNotification();
  final AuthController _authController = Get.put(AuthController());
  // await tambahBanyakData(daftarData);
  var cart = FlutterCart();
  await cart.initializeCart(isPersistenceSupportEnabled: true);
  Get.put(AuthController());
  runApp(
    GetMaterialApp(
      title: "Catering App",
      initialRoute: _authController.isLoggedIn.value
          ? (_authController.role.value == 'admin'
          ? Routes.HOMEADMIN
          : _authController.role.value == 'kurir'
          ? Routes.HOMEKURIR
          : Routes.HOME)
          : Routes.MAINLOGIN,
      getPages: AppPages.routes,
    ),
  );
}
