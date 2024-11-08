import 'package:catering_mobile/app/controllers/auth_controller.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Keluhan extends StatelessWidget {
  final _unselectedBackgroundColor = Color(0xFFECD7D7);
  final TextEditingController _orderNumberController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final AuthController _authController = Get.put(AuthController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _unselectedBackgroundColor,
      appBar: AppBar(
        backgroundColor: _unselectedBackgroundColor,
        title: Text('Keluhan Pelanggan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor Pesanan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _orderNumberController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF2E3E3),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Color(0xFFB4A5A5), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Color(0xFF23A1F2), width: 2.5),
                ),
                hintText: 'Nomor Pesanan',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Isi Keluhan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _complaintController,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF2E3E3),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Color(0xFFB4A5A5), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Color(0xFF23A1F2), width: 2.5),
                ),
                hintText: 'Silahkan masukkan keluhan anda',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _submitComplaint();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Color(0xFFFF3131),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Kirim',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitComplaint() async {
    String orderNumber = _orderNumberController.text.trim();
    String complaint = _complaintController.text.trim();

    if (orderNumber.isEmpty || complaint.isEmpty) {
      Get.snackbar('Error', 'Semua kolom harus diisi',
          backgroundColor: Colors.red);
      return;
    }

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Mengambil username dari AuthController
        String username = _authController.username.value;

        // Mengirim data keluhan ke Firestore
        await _firestore.collection('complaints').add({
          'username': username,
          'orderNumber': orderNumber,
          'complaint': complaint,
          'createdAt': FieldValue.serverTimestamp(),
        });

        Get.snackbar('Success', 'Keluhan berhasil dikirim',
            backgroundColor: Colors.green);
        Get.offAllNamed(Routes.PROFILE);
      } else {
        Get.snackbar('Error', 'User tidak terdaftar, silakan login',
            backgroundColor: Colors.red);
      }
    } catch (error) {
      Get.snackbar('Error', 'Gagal mengirim keluhan: $error',
          backgroundColor: Colors.red);
    }
  }
}
