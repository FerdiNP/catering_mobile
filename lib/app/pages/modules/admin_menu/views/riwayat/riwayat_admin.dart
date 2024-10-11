import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatAdmin extends StatefulWidget {
  @override
  _RiwayatAdminState createState() => _RiwayatAdminState();
}

class _RiwayatAdminState extends State<RiwayatAdmin> {
  // Dummy data transaksi
  final List<Map<String, String>> transactions = [
    {
      'transactionNo': '001',
      'user': 'User 1',
      'date': '10-10-2024',
      'total': 'Rp 150.000',
    },
    {
      'transactionNo': '002',
      'user': 'User 2',
      'date': '09-10-2024',
      'total': 'Rp 200.000',
    },
    {
      'transactionNo': '003',
      'user': 'User 3',
      'date': '08-10-2024',
      'total': 'Rp 120.000',
    },
  ];

  List<Map<String, String>> filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    filteredTransactions = transactions; // Awalnya, tampilkan semua transaksi
  }

  void filterTransactions(String query) {
    setState(() {
      filteredTransactions = transactions.where((transaction) {
        return transaction['transactionNo']!.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECD7D7),
      appBar: AppBar(
        title: Text('Riwayat Transaksi Pengguna'),
        backgroundColor: Color(0xFFECD7D7),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar untuk mencari nomor transaksi
            TextField(
              decoration: InputDecoration(
                labelText: 'Cari Nomor Transaksi',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Color(0xFFFF3131)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                filterTransactions(value);
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = filteredTransactions[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFFFF3131),
                        child: Icon(Icons.receipt, color: Colors.white),
                      ),
                      title: Text(
                        'No Transaksi: ${transaction['transactionNo']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User: ${transaction['user']}'),
                          Text('Tanggal: ${transaction['date']}'),
                          Text('Total: ${transaction['total']}'),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Logika untuk melihat detail transaksi
                        print('Lihat detail transaksi');
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
