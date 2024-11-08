import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Voucher extends StatefulWidget {
  @override
  _VoucherState createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  final Color _backgroundColor = Color(0xFFECD7D7);
  final CollectionReference _voucherCollection = FirebaseFirestore.instance.collection('vouchers');
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        title: Text('Voucher'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {}); // Triggers rebuild to update search results
              },
              decoration: InputDecoration(
                labelText: 'Cari Kode Voucher',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Color(0xFFFF3131)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Kupon Tersedia',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _voucherCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  String query = _searchController.text.toLowerCase();
                  List<QueryDocumentSnapshot> voucherItems = snapshot.data!.docs.where((voucher) {
                    String kodeVoucher = voucher['kodeVoucher'] ?? '';
                    String statusVoucher = voucher['status'] ?? '';
                    return kodeVoucher.toLowerCase().contains(query) && statusVoucher != 'unavailable';
                  }).toList();

                  if (voucherItems.isEmpty) {
                    return Center(child: Text('Voucher Tidak Ditemukan'));
                  }

                  return ListView.builder(
                    itemCount: voucherItems.length,
                    itemBuilder: (context, index) {
                      final voucher = voucherItems[index];
                      String kodeVoucher = voucher['kodeVoucher'] ?? 'Kode Voucher Tidak Diketahui';
                      String diskonVoucher = '${voucher.get('diskonVoucher')?.toString() ?? '0'}%';
                      String deskripsiVoucher = voucher['deskripsiVoucher'] ?? 'Deskripsi Tidak Diketahui';

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(Icons.local_offer, color: Colors.orange, size: 40),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      kodeVoucher,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      diskonVoucher,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      deskripsiVoucher,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor: Colors.orange,
                                  elevation: 3,
                                ),
                                child: Text('Apply', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return Center(child: Text('Tidak ada voucher yang tersedia.'));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
