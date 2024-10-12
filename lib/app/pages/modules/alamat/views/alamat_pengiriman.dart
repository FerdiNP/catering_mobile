import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamatPengiriman extends StatefulWidget {
  @override
  _AlamatPengirimanState createState() => _AlamatPengirimanState();
}

class _AlamatPengirimanState extends State<AlamatPengiriman> {
  final _selectedColor = Color(0xFFECD7D7);
  final _unselectedColor = Colors.white;
  final _selectedBackgroundColor = Color(0xFFFF3131);
  final _unselectedBackgroundColor = Color(0xFFECD7D7);
  final _borderColor = Color(0xFFCDE7BE);

  final List<Map<String, String>> addresses = [
    {
      'type': 'Rumah',
      'recipient': 'Budi Santoso',
      'address': 'Jl. Merdeka No. 1, Jakarta',
    },
    {
      'type': 'Kos',
      'recipient': 'Siti Aminah',
      'address': 'Jl. Sudirman No. 2, Bandung',
    },
    {
      'type': 'Rumah',
      'recipient': 'Ahmad Subandi',
      'address': 'Jl. Pahlawan No. 3, Surabaya',
    },
  ];

  int? _selectedAddressIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _unselectedBackgroundColor,
      appBar: AppBar(
        backgroundColor: _unselectedBackgroundColor,
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Row(
                      children: [
                        Radio<int>(
                          value: index,
                          groupValue: _selectedAddressIndex,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedAddressIndex = value;
                            });
                          },
                        ),
                        Text(address['type']!),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nama Penerima: ${address['recipient']!}'),
                        SizedBox(height: 4),
                        Text(
                          address['address']!,
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
                            Get.toNamed(Routes.FORMALAMAT);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Pilih',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                backgroundColor: Color(0xFFFF3131),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(height: 16,),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
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
              onPressed: () {
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
