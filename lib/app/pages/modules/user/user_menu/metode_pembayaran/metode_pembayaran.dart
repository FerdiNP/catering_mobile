import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  var connectedMethods = [
    {
      'type': 'Kartu Kredit',
      'details': 'Nama Bank: Bank ABC\nNo. Kartu: **** **** **** 1234\nSaldo: Rp 500.000',
      'icon': Icons.credit_card,
    },
    {
      'type': 'Bank Transfer',
      'details': 'Nama Bank: Bank XYZ\nNo. Rekening: 1234567890\nSaldo: Rp 1.200.000',
      'icon': Icons.account_balance,
    },
    {
      'type': 'E-Wallet',
      'details': 'Nama E-Wallet: E-Wallet XYZ\nSaldo: Rp 300.000',
      'icon': Icons.account_balance_wallet,
    },
  ].obs;
}

class MetodePembayaran extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECD7D7),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('Metode Pembayaran'),
        backgroundColor: Color(0xFFECD7D7),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Metode Pembayaran Terhubung',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.connectedMethods.length,
                itemBuilder: (context, index) {
                  final method = controller.connectedMethods[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: Icon(method['icon'] as IconData),
                      title: Text(method['type'] as String),
                      subtitle: Text(method['details'] as String),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, index);
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tambah Metode Pembayaran',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('Kartu Kredit/Debit'),
                    onTap: () {
                    },
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.account_balance),
                    title: Text('Bank'),
                    onTap: () {
                    },
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.account_balance_wallet),
                    title: Text('E-Wallet'),
                    onTap: () {
                    },
                  ),
                ),
              ],
            ),
          ),
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
          content: Text('Apakah Anda yakin ingin menghapus metode pembayaran ini?'),
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
                  SnackBar(content: Text('Metode pembayaran telah dihapus')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
