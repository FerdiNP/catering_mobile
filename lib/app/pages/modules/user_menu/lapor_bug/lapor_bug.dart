import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaporBug extends StatelessWidget {
  final _unselectedBackgroundColor = Color(0xFFECD7D7);
  final List<String> _bugTypes = ['Crash', 'UI Issue', 'Performance', 'Other']; // Options for bug type
  String? _selectedBugType; // Variable to hold the selected bug type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _unselectedBackgroundColor,
      appBar: AppBar(
        backgroundColor: _unselectedBackgroundColor,
        title: Text('Lapor Bug'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigasi kembali
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nama Lengkap
            Text(
              'Nama Lengkap',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
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
                hintText: 'Nama lengkap',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 16),

            // Tipe Bug - Dropdown
            Text(
              'Tipe Bug',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Container(
              child: DropdownButtonFormField<String>(
                value: _selectedBugType,
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
                items: _bugTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  _selectedBugType = newValue; // Update the selected value
                },
              ),
            ),
            SizedBox(height: 16),

            // Masalah Aplikasi
            Text(
              'Masalah Aplikasi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
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
            SizedBox(height: 16),

            // Kirim Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Color(0xFFFF3131), // Warna tombol
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
}
