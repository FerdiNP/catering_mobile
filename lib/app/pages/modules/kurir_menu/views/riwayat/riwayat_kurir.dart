import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatKurir extends StatefulWidget {
  @override
  _RiwayatKurirState createState() => _RiwayatKurirState();
}

class _RiwayatKurirState extends State<RiwayatKurir> {
  // Dummy data pengiriman
  final List<Map<String, String>> deliveries = [
    {
      'deliveryNo': '001',
      'user': 'User 1',
      'date': '10-10-2024',
      'total': 'Rp 150.000',
      'address': 'Jl. Merpati No. 12',
      'status': 'Terkirim',
    },
    {
      'deliveryNo': '002',
      'user': 'User 2',
      'date': '09-10-2024',
      'total': 'Rp 200.000',
      'address': 'Jl. Kenari No. 45',
      'status': 'Terkirim',
    },
    {
      'deliveryNo': '003',
      'user': 'User 3',
      'date': '08-10-2024',
      'total': 'Rp 120.000',
      'address': 'Jl. Cendrawasih No. 7',
      'status': 'Terkirim',
    },
  ];

  List<Map<String, String>> filteredDeliveries = [];

  @override
  void initState() {
    super.initState();
    filteredDeliveries = deliveries; // Awalnya, tampilkan semua pengiriman
  }

  void filterDeliveries(String query) {
    setState(() {
      filteredDeliveries = deliveries.where((delivery) {
        return delivery['deliveryNo']!.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECD7D7),
      appBar: AppBar(
        title: Text('Riwayat Pengiriman Kurir'),
        backgroundColor: Color(0xFFECD7D7),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar untuk mencari nomor pengiriman
            TextField(
              decoration: InputDecoration(
                labelText: 'Cari Nomor Pengiriman',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Color(0xFFFF3131)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                filterDeliveries(value);
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDeliveries.length,
                itemBuilder: (context, index) {
                  final delivery = filteredDeliveries[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFFFF3131),
                        child: Icon(Icons.local_shipping, color: Colors.white),
                      ),
                      title: Text(
                        'No Pengiriman: ${delivery['deliveryNo']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Penerima: ${delivery['user']}'),
                          Text('Tanggal: ${delivery['date']}'),
                          Text('Total Biaya: ${delivery['total']}'),
                          Text('Alamat: ${delivery['address']}'),
                          Text('Status: ${delivery['status']}'),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Logika untuk melihat detail pengiriman
                        print('Lihat detail pengiriman');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
