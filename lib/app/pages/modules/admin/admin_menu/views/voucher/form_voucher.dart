import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FormVoucher extends StatefulWidget {
  @override
  _FormVoucherState createState() => _FormVoucherState();
}

class _FormVoucherState extends State<FormVoucher> {
  final _selectedColor = Color(0xFFECD7D7);
  final _unselectedColor = Colors.white;
  final _selectedBackgroundColor = Color(0xFFFF3131);
  final _unselectedBackgroundColor = Color(0xFFECD7D7);
  final _borderColor = Color(0xFFCDE7BE);

  final TextEditingController _kodeVoucherController = TextEditingController();
  final TextEditingController _diskonVoucherController = TextEditingController();
  final TextEditingController _deskripsiVoucherController = TextEditingController();

  String? _selectedStatus;

  String voucherId = '';
  String? kodeVoucher;
  int? diskonVoucher;
  String? deskripsiVoucher;
  String? status;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null) {
      voucherId = args['menuId'] ?? '';
      kodeVoucher = args['kodeVoucher'] ?? '';
      diskonVoucher = args['diskonVoucher'] ?? 0;
      deskripsiVoucher = args['deskripsiVoucher'] ?? '';
      status = args['status'] == 'available' ? 'available' : 'unavailable';

      _kodeVoucherController.text = kodeVoucher!;
      _deskripsiVoucherController.text = diskonVoucher.toString();
      _diskonVoucherController.text = deskripsiVoucher!;
      _selectedStatus = status;
    }
  }

  Future<void> _saveVoucher() async {
    try {
      final voucherData = {
        'kodeVoucher': _kodeVoucherController.text,
        'diskonVoucher': int.tryParse(_diskonVoucherController.text) ?? 0,
        'deskripsiVoucher': _deskripsiVoucherController.text,
        'status': _selectedStatus,
        'createdAt': FieldValue.serverTimestamp(),
      };

      if (voucherId.isNotEmpty){
        await FirebaseFirestore.instance.collection('vouchers').doc(voucherId).update(voucherData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voucher berhasil diperbarui')),
        );
      } else {
        await FirebaseFirestore.instance.collection('vouchers').add(voucherData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voucher berhasil disimpan')),
        );
      }

      Get.back();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan Voucher')),
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
          voucherId.isNotEmpty ? 'Update Voucher' : 'Tambah Voucher',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kode Voucher',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _kodeVoucherController,
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
                hintText: 'Kode Voucher',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Diskon Voucher',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _diskonVoucherController,
              keyboardType: TextInputType.number,
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
                hintText: 'Diskon Voucher',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Deskripsi Voucher',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _deskripsiVoucherController,
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
                hintText: 'Deskripsi Voucher',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Status Voucher',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            // Pada bagian DropdownButtonFormField
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              items: [
                DropdownMenuItem(value: 'available', child: Text('Tersedia')),
                DropdownMenuItem(value: 'unavailable', child: Text('Tidak Tersedia')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
              isExpanded: false, // Membuat hint memenuhi lebar
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
              hint: Text('Pilih Status', style: TextStyle(color: Colors.grey)),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveVoucher,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  voucherId.isNotEmpty ? 'Simpan Voucher' : 'Tambah Voucher',
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
