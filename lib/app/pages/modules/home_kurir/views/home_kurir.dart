import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeKurir extends StatelessWidget {
  final _selectedColor = Color(0xFFECD7D7);
  final _unselectedColor = Colors.white;
  final _selectedBackgroundColor = Color(0xFFFF3131);
  final _unselectedBackgroundColor = Color(0xFFECD7D7);
  final _borderColor = Color(0xFFCDE7BE);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECD7D7),
      appBar: AppBar(
        backgroundColor: Color(0xFFECD7D7),
        title: Text('Home Kurir'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Get.offNamed(Routes.KURIRLOGIN);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/1.png'),
                  minRadius: 30,
                  maxRadius: 50,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Kurir',
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Informasi Akun',
                          style:
                          TextStyle(fontSize: 16, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[700],
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.receipt_long, color: Colors.black, size: 30),
              title: Text('Riwayat Pengiriman'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Get.toNamed(Routes.RIWAYATKURIR);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.local_shipping, color: Colors.black, size: 30),
              title: Text('Status Pengiriman'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Get.toNamed(Routes.STATUSPENGIRIMAN);
              },
            ),
            Divider(),
            TextButton(
              onPressed: () {
                Get.offNamed(Routes.HOMEADMIN);
              },
              child: const Text(
                'Home Admin!',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
