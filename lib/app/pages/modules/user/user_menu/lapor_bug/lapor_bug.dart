import 'package:catering_mobile/app/controllers/auth_controller.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LaporBug extends StatelessWidget {
  final _unselectedBackgroundColor = Color(0xFFECD7D7);
  final TextEditingController _problemController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _selectedBugType;

  final AuthController _authController = Get.put(AuthController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _unselectedBackgroundColor,
      appBar: AppBar(
        backgroundColor: _unselectedBackgroundColor,
        title: Text('Lapor Bug'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tipe Bug',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Container(
              child: DropdownButtonFormField(
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
                ),
                hint: Text('Pilih tipe bug'),
                value: _selectedBugType,
                items: [
                  DropdownMenuItem(value: 'Crash', child: Text('Crash')),
                  DropdownMenuItem(value: 'UI Issue', child: Text('UI Issue')),
                  DropdownMenuItem(value: 'Performance', child: Text('Performance')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) {
                  _selectedBugType = value;
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Masalah Aplikasi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _problemController,
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
                hintText: 'Apakah aplikasi anda sedang bermasalah?',
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
    String problem = _problemController.text.trim();

    // Check if all fields are filled
    if (_selectedBugType == null) {
      Get.snackbar('Error', 'Tipe Bug harus dipilih',
          backgroundColor: Colors.red);
      return;
    }

    if (problem.isEmpty) {
      Get.snackbar('Error', 'Masalah Aplikasi harus diisi',
          backgroundColor: Colors.red);
      return;
    }

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Mengambil username dari AuthController
        String username = _authController.username.value;

        // Mengirim data keluhan ke Firestore
        await _firestore.collection('bug-reports').add({
          'username': username,
          'bugType': _selectedBugType,
          'problem': problem,
          'createdAt': FieldValue.serverTimestamp(),
        });

        Get.snackbar('Success', 'Lapor Bug berhasil dikirim',
            backgroundColor: Colors.green);
        Get.offAllNamed(Routes.PROFILE);
      } else {
        Get.snackbar('Error', 'User tidak terdaftar, silakan login',
            backgroundColor: Colors.red);
      }
    } catch (error) {
      Get.snackbar('Error', 'Gagal mengirim laporan bug: $error',
          backgroundColor: Colors.red);
    }
  }
}
