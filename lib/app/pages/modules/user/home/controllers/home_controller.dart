import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedMenu = ''.obs;
  var menuData = {}.obs;

  final foodItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFoodItems();
    fetchMenus();
  }

  void clear() {
   foodItems.clear();  // Menghapus semua item di keranjang
  }

  void fetchMenus() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance.collection('menus').get();
      foodItems.value = querySnapshot.docs.map((doc) {
        return {
          'idMenu': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    } catch (e) {
      print("Error mengambil data menu: $e");
    }
  }

  // Function to fetch food items from Firestore
  void fetchFoodItems() async {
    try {
      // Access the 'menus' collection in Firestore
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('menus').where(
          'status', isEqualTo: 'available').get();

      // Transform each document in the collection into a map and add to foodItems list
      foodItems.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error fetching food items: $e");
    }
  }
}
