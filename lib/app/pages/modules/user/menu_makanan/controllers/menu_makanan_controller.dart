import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MenuMakananController extends GetxController {
  var selectedMenu = ''.obs;
  var menuData = {}.obs;

  final foodItems = <Map<String, dynamic>>[].obs;
  final drinkItems = <Map<String, dynamic>>[].obs;
  final otherItems = <Map<String, dynamic>>[].obs;

  final menuItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMenuItems();
  }

  void fetchMenuItems() async {
    try {
      var menuCollection = FirebaseFirestore.instance.collection('menus').where('status', isEqualTo: 'available');

      // Fetch Food Items
      var foodQuerySnapshot = await menuCollection.where('kategoriMenu', isEqualTo: 'Makanan').get();
      foodItems.assignAll(
        foodQuerySnapshot.docs.map((doc) {
          var data = doc.data();
          return {
            'idMenu': doc.id,
            'namaMenu': data['namaMenu'] ?? 'Untitled', // Pastikan ada namaMenu
            'deskripsiMenu': data['deskripsiMenu'] ?? 'No Description', // Pastikan ada deskripsi
            'gambarMenu': data['gambarMenu'] ?? '', // Pastikan ada gambarMenu
            'hargaMenu': data['hargaMenu'] ?? 0, // Pastikan ada hargaMenu
          };
        }).toList(),
      );

      // Fetch Drink Items
      var drinkQuerySnapshot = await menuCollection.where('kategoriMenu', isEqualTo: 'Minuman').get();
      drinkItems.assignAll(
        drinkQuerySnapshot.docs.map((doc) {
          var data = doc.data();
          return {
            'idMenu': doc.id,
            'namaMenu': data['namaMenu'] ?? 'Untitled',
            'deskripsiMenu': data['deskripsiMenu'] ?? 'No Description',
            'gambarMenu': data['gambarMenu'] ?? '',
            'hargaMenu': data['hargaMenu'] ?? 0,
          };
        }).toList(),
      );

      // Fetch Other Items
      var otherQuerySnapshot = await menuCollection.where('kategoriMenu', isEqualTo: 'Lainnya').get();
      otherItems.assignAll(
        otherQuerySnapshot.docs.map((doc) {
          var data = doc.data();
          return {
            'idMenu': doc.id,
            'namaMenu': data['namaMenu'] ?? 'Untitled',
            'deskripsiMenu': data['deskripsiMenu'] ?? 'No Description',
            'gambarMenu': data['gambarMenu'] ?? '',
            'hargaMenu': data['hargaMenu'] ?? 0,
          };
        }).toList(),
      );
    } catch (e) {
      print("Error fetching menu items: $e");
    }
  }

}
