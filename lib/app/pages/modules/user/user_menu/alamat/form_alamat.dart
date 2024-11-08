import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FormAlamat extends StatefulWidget {
  @override
  _FormAlamatState createState() => _FormAlamatState();
}

class _FormAlamatState extends State<FormAlamat> {
  final _selectedColor = Color(0xFFECD7D7);
  final _unselectedColor = Colors.white;
  final _selectedBackgroundColor = Color(0xFFFF3131);
  final _unselectedBackgroundColor = Color(0xFFECD7D7);
  final _borderColor = Color(0xFFCDE7BE);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId;
  late CollectionReference _addressCollection;
  final TextEditingController _namaAlamatController = TextEditingController();
  final TextEditingController _namaPenerimaController = TextEditingController();
  final TextEditingController _alamatLengkapController = TextEditingController();

  String addressId = '';
  String? namaAlamat;
  String? namaPenerima;
  String? alamatLengkap;

  @override
  void initState() {
    super.initState();
    userId = _auth.currentUser!.uid;
    _addressCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('address');
    final args = Get.arguments;
    if (args != null) {
      addressId = args['addressId'] ?? '';
      namaAlamat = args['namaAlamat'] ?? '';
      namaPenerima = args['namaPenerima'] ?? '';
      alamatLengkap = args['alamatLengkap'] ?? '';

      _namaAlamatController.text = namaAlamat!;
      _namaPenerimaController.text = namaPenerima!;
      _alamatLengkapController.text = alamatLengkap!;
    }
  }

  Future<void> _saveAddress() async {
    try {
      final addressData = {
        'namaAlamat': _namaAlamatController.text,
        'namaPenerima': _namaPenerimaController.text,
        'alamatLengkap': _alamatLengkapController.text,
        'createdAt': FieldValue.serverTimestamp(),
      };


      if (addressId.isNotEmpty){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('address')
            .doc(addressId)
            .update(addressData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Alamat berhasil diperbarui')),
        );
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('address')
            .add(addressData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Alamat berhasil disimpan')),
        );
      }
      Get.back();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan Alamat')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _unselectedBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: _unselectedBackgroundColor,
        title: Text(
          addressId.isNotEmpty ? 'Update Alamat' : 'Tambah Alamat',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Alamat',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _namaAlamatController,
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
                hintText: 'Nama Alamat',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nama Penerima',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _namaPenerimaController,
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
                hintText: 'Nama Penerima',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Alamat Lengkap',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _alamatLengkapController,
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
                hintText: 'Alamat Lengkap',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  addressId.isNotEmpty ? 'Simpan Alamat' : 'Tambah Alamat',
                  style: TextStyle(color: _unselectedBackgroundColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
