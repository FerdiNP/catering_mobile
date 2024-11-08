import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlamatPengiriman extends StatefulWidget {
  @override
  _AlamatPengirimanState createState() => _AlamatPengirimanState();
}

class _AlamatPengirimanState extends State<AlamatPengiriman> {
  final Color _backgroundColor = Color(0xFFECD7D7);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId;
  late CollectionReference _addressCollection;

  String? _selectedAddressId; // To hold the selected address ID

  @override
  void initState() {
    super.initState();
    // Check if user is logged in before accessing userId
    User? user = _auth.currentUser;
    userId = user!.uid; // Get the current user ID
    _addressCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('address');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        title: Text('Daftar Alamat'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(Routes.FORMALAMAT);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _addressCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final addressItems = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: addressItems.length,
            itemBuilder: (context, index) {
              final address = addressItems[index];
              final addressId = address.id;

              String namaAlamat = address['namaAlamat'] ?? 'Nama Alamat';
              String namaPenerima = address.get('namaPenerima') ?? 'Penerima';
              String alamatLengkap = address['alamatLengkap'] ?? 'Alamat';

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  title: Row(
                    children: [
                      // Radio Button
                      Radio<String>(
                        value: addressId, // Use addressId as the value
                        groupValue: _selectedAddressId, // Bind to selected address ID
                        onChanged: (String? value) {
                          setState(() {
                            _selectedAddressId = value; // Update selected address ID
                          });
                        },
                      ),
                      Expanded(
                        child: Text(namaAlamat),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama Penerima: ${namaPenerima}'),
                      SizedBox(height: 4),
                      Text(
                        alamatLengkap,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Get.toNamed(Routes.FORMALAMAT, arguments: {
                            'addressId': addressId,
                            'namaAlamat': address['namaAlamat'],
                            'namaPenerima': address['namaPenerima'],
                            'alamatLengkap': address['alamatLengkap'],
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, addressItems[index].id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: _backgroundColor,
        child: Container(
          width: double.infinity, // Full width
          child: Center(
            child: SizedBox(
              width: 200, // Set the desired width for the button
              child: FloatingActionButton(
                onPressed: () {
                  if (_selectedAddressId != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Alamat telah dipilih')),
                    );
                    Get.back(result: _selectedAddressId);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Silakan pilih alamat terlebih dahulu')),
                    );
                  }
                },
                child: Text(
                  'Pilih',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Color(0xFFFF3131),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String addressId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus alamat ini?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection('address')
                    .doc(addressId)
                    .delete();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Alamat telah dihapus')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
