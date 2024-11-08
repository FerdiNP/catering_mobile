import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;
  RxString name = ''.obs;
  RxString username = ''.obs;
  RxString role = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    isLoggedIn.value = _prefs.containsKey('user_token');
  }

  Future<void> checkUserRole() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        role.value = userDoc['role'] ?? 'user';
        isLoggedIn.value = true;
      } else {
        isLoggedIn.value = false;
      }
    } else {
      isLoggedIn.value = false;
    }
  }

  Future<bool> registerUser(String email, String password, String username, String name, String role) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await addUserToFirestore(userCredential.user!, username, name, role);

      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);
      return true;
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addUserToFirestore(User user, String username, String name, String? role) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(user.uid).set({
      'username': username,
      'name': name,
      'email': user.email,
      'role': role,
    });
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _prefs.setString('user_token', _auth.currentUser!.uid);
      isLoggedIn.value = true;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      if (userDoc.exists) {
        name.value = userDoc['name'] ?? 'Guest';
        username.value = userDoc['username'] ?? 'Unknown';
        role.value = userDoc['role'] ?? 'User';

        if (role.value == 'Admin') {
          Get.offAllNamed(Routes.HOMEADMIN);
        } else if (role.value == 'User') {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar('Error', 'Unauthorized role', backgroundColor: Colors.red);
        }
      } else {
        Get.snackbar('Error', 'User data not found', backgroundColor: Colors.red);
      }
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginKurir(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _prefs.setString('user_token', _auth.currentUser!.uid);
      isLoggedIn.value = true;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      if (userDoc.exists) {
        name.value = userDoc['name'] ?? 'Guest';
        username.value = userDoc['username'] ?? 'Unknown';
        role.value = userDoc['role'] ?? 'Kurir';

        if (role.value == 'Kurir') {
          Get.offAllNamed(Routes.HOMEKURIR);
        } else {
          Get.snackbar('Error', 'Unauthorized role for Kurir login', backgroundColor: Colors.red);
        }
      } else {
        Get.snackbar('Error', 'User data not found', backgroundColor: Colors.red);
      }
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    _prefs.remove('user_token');
    isLoggedIn.value = false;
    _auth.signOut();
    Get.offAllNamed(Routes.MAINLOGIN);
  }
}
