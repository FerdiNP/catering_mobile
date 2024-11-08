import 'package:catering_mobile/app/controllers/auth_controller.dart';
import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfile extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECD7D7),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color(0xFFECD7D7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed(Routes.HOME);
          },
        ),
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authController.logout();
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
                    // Menampilkan nama user yang diambil dari AuthController
                    Obx(() => Text(
                      _authController.name.value.isNotEmpty
                        ? _authController.name.value
                        : 'User',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    )),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Informasi Akun',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
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
              leading: Icon(Icons.password, color: Colors.black, size: 30),
              title: Text('Update Password'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Get.toNamed(Routes.UPDATEPASSWORD);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.receipt_long, color: Colors.black, size: 30),
              title: Text('Riwayat Transaksi'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Get.toNamed(Routes.RIWAYATUSER);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.payment, color: Colors.black, size: 30),
              title: Text('Metode Pembayaran'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Get.toNamed(Routes.METODEPEMBAYARAN);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.black, size: 30),
              title: Text('Alamat Pengiriman'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Get.toNamed(Routes.MANAGEALAMAT);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black, size: 30),
              title: Text('Pengaturan'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                // Get.toNamed(Routes.PENGATURANUSER);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.report_problem, color: Colors.black, size: 30),
              title: Text('Keluhan'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Get.toNamed(Routes.KELUHAN);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.bug_report, color: Colors.black, size: 30),
              title: Text('Lapor Bug'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Get.toNamed(Routes.LAPORBUG);
              },
            ),
            Divider(),
            TextButton(
              onPressed: () {
                Get.offAllNamed(Routes.HOMEADMIN);
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
            TextButton(
              onPressed: () {
                Get.offAllNamed(Routes.HOMEKURIR);
              },
              child: const Text(
                'Home Kurir!',
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
