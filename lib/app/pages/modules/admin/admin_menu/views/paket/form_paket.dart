import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FormPaket extends StatefulWidget {
  @override
  _FormPaketState createState() => _FormPaketState();
}

class _FormPaketState extends State<FormPaket> {
  final _selectedColor = Color(0xFFECD7D7);
  final _unselectedColor = Colors.white;
  final _selectedBackgroundColor = Color(0xFFFF3131);
  final _unselectedBackgroundColor = Color(0xFFECD7D7);
  final _borderColor = Color(0xFFCDE7BE);

  final TextEditingController _namaPaketController = TextEditingController();
  final TextEditingController _deskripsiPaketController = TextEditingController();
  final TextEditingController _hargaPaketController = TextEditingController();

  File? _image;
  String? _selectedStatus;

  String packageId = '';
  String? namaPaket;
  String? deskripsiPaket;
  int? hargaPaket;
  String? status;
  String? gambarPaket;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null) {
      packageId = args['menuId'] ?? '';
      namaPaket = args['namaPaket'] ?? '';
      deskripsiPaket = args['deskripsiPaket'] ?? '';
      hargaPaket = args['hargaPaket'] ?? 0;
      status = args['status'] == 'available' ? 'available' : 'unavailable';
      gambarPaket = args['gambarPaket'];

      _namaPaketController.text = namaPaket!;
      _deskripsiPaketController.text = deskripsiPaket!;
      _hargaPaketController.text = hargaPaket.toString();
      _selectedStatus = status;
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        print("Picked cover image path: ${pickedImage.path}"); // Debugging
      });
    }
  }

  Future<String> _uploadImage(File image, String folder) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef = FirebaseStorage.instance.ref().child('$folder/$fileName');

    UploadTask uploadTask = storageRef.putFile(image);
    await uploadTask;

    String? downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  Future<void> _savePackage() async {
    try {
      if (_image != null && !_isUploading) {
        _isUploading = true;
        gambarPaket = await _uploadImage(_image!, 'package_images');

        if (gambarPaket == null) {
          // Handle upload failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengunggah gambar')),
          );
          _isUploading = false; // Reset upload flag
          return;
        }
      }

      final packageData = {
        'namaPaket': _namaPaketController.text,
        'deskripsiPaket': _deskripsiPaketController.text,
        'hargaPaket': int.tryParse(_hargaPaketController.text) ?? 0,
        'gambarPaket': gambarPaket,
        'status': _selectedStatus,
        'createdAt': FieldValue.serverTimestamp(),
      };

      if (packageId.isNotEmpty){
        await FirebaseFirestore.instance.collection('packages').doc(packageId).update(packageData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Paket berhasil diperbarui')),
        );
      } else {
        await FirebaseFirestore.instance.collection('packages').add(packageData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Paket berhasil disimpan')),
        );
      }
      Get.back();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan paket')),
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
          packageId.isNotEmpty ? 'Update Paket' : 'Tambah Paket',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Paket',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _namaPaketController,
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
                hintText: 'Nama Paket',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Deskripsi Paket',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _deskripsiPaketController,
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
                hintText: 'Deskripsi Paket',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Harga Paket',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _hargaPaketController,
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
                hintText: 'Harga Paket',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Status Paket',
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
            Text(
              'Gambar Paket',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFFF2E3E3),
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Color(0xFFB4A5A5), width: 2),
                ),
                child: Center( // Memastikan konten di tengah Container
                  child: _image == null && gambarPaket == null
                      ? Text('Pilih Gambar Paket', style: TextStyle(color: Colors.grey))
                      : _image != null
                      ? Image.file(_image!, height: 120, width: 120, fit: BoxFit.cover)
                      : Image.network(gambarPaket!, height: 120, width: 120, fit: BoxFit.cover),
                ),
              ),
            ),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _savePackage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  packageId.isNotEmpty ? 'Simpan Paket' : 'Tambah Paket',
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
