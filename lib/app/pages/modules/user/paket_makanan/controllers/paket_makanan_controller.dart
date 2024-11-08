import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PaketMakananController extends GetxController {
  var selectedMenu = ''.obs;
  var paketData = {}.obs;

  final packageItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPackageItems();
    fetchPackages();
  }

  void fetchPackages() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance.collection('packages').get();
      packageItems.value = querySnapshot.docs.map((doc) {
        return {
          'idPaket': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();

      print(packageItems);
    } catch (e) {
      print("Error mengambil data paket: $e");
    }
  }

  void fetchPackageItems() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('packages').where(
          'status', isEqualTo: 'available').get();

      packageItems.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error fetching package items: $e");
    }
  }
}
