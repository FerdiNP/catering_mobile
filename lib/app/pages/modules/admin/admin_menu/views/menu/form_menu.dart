import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FormMenu extends StatefulWidget {
  @override
  _FormMenuState createState() => _FormMenuState();
}

class _FormMenuState extends State<FormMenu> {
  final _selectedColor = Color(0xFFECD7D7);
  final _unselectedColor = Colors.white;
  final _selectedBackgroundColor = Color(0xFFFF3131);
  final _unselectedBackgroundColor = Color(0xFFECD7D7);
  final _borderColor = Color(0xFFCDE7BE);

  final TextEditingController _namaMenuController = TextEditingController();
  final TextEditingController _deskripsiMenuController = TextEditingController();
  final TextEditingController _hargaMenuController = TextEditingController();

  File? _image;
  String? _selectedStatus;

  String menuId = '';
  String? namaMenu;
  String? deskripsiMenu;
  int? hargaMenu;
  String? status;
  String? gambarMenu;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null) {
      menuId = args['menuId'] ?? '';
      namaMenu = args['namaMenu'] ?? '';
      deskripsiMenu = args['deskripsiMenu'] ?? '';
      hargaMenu = args['hargaMenu'] ?? 0;
      status = args['status'] == 'available' ? 'available' : 'unavailable';
      gambarMenu = args['gambarMenu'];

      _namaMenuController.text = namaMenu!;
      _deskripsiMenuController.text = deskripsiMenu!;
      _hargaMenuController.text = hargaMenu.toString();
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


  Future<void> _saveMenu() async {
  try {
    if (_image != null && !_isUploading) {
      _isUploading = true;
      gambarMenu = await _uploadImage(_image!, 'menu_images');

      if (gambarMenu == null) {
        // Handle upload failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengunggah gambar')),
        );
        _isUploading = false; // Reset upload flag
        return;
      }
    }

    final menuData = {
      'namaMenu': _namaMenuController.text,
      'deskripsiMenu': _deskripsiMenuController.text,
      'hargaMenu': int.tryParse(_hargaMenuController.text) ?? 0,
      'gambarMenu': gambarMenu,
      'status': _selectedStatus,
      'createdAt': FieldValue.serverTimestamp(),
    };

      if (menuId.isNotEmpty){
        await FirebaseFirestore.instance.collection('menus').doc(menuId).update(menuData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Menu berhasil diperbarui')),
        );
      } else {
        await FirebaseFirestore.instance.collection('menus').add(menuData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Menu berhasil disimpan')),
        );
      }

      Get.back();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan menu')),
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
          menuId.isNotEmpty ? 'Update Menu' : 'Tambah Menu',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Menu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _namaMenuController,
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
                hintText: 'Nama Menu',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Deskripsi Menu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _deskripsiMenuController,
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
                hintText: 'Deskripsi Menu',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Harga Menu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _hargaMenuController,
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
                hintText: 'Harga Menu',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Status Menu',
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
              'Gambar Produk',
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
                  child: _image == null && gambarMenu == null
                      ? Text('Pilih Gambar Produk', style: TextStyle(color: Colors.grey))
                      : _image != null
                      ? Image.file(_image!, height: 120, width: 120, fit: BoxFit.cover)
                      : Image.network(gambarMenu!, height: 120, width: 120, fit: BoxFit.cover),
                ),
              ),
            ),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveMenu,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  menuId.isNotEmpty ? 'Simpan Menu' : 'Tambah Menu',
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
