import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pembayaran extends StatefulWidget {
  @override
  _PembayaranState createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  final _selectedBackgroundColor = Color(0xFFFF3131);
  final _unselectedBackgroundColor = Color(0xFFECD7D7);

  String? _selectedPaymentMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _unselectedBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Pembayaran',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rincian Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16),

            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: _unselectedBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text('Jumlah', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Total Asli: 70.000'),
                  const SizedBox(height: 8),
                  const Text('Diskon: 20.000'),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text('Total: 50.000',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text('Metode Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            _buildPaymentMethod(icon: Icons.money, title: 'Cash', value: 'Cash'),
            _buildPaymentMethod(icon: Icons.qr_code, title: 'QR', value: 'QR'),
            _buildPaymentMethod(icon: Icons.account_balance, title: 'Bank', value: 'Bank'),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 70,
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedBackgroundColor,
              padding: EdgeInsets.all(0),
              minimumSize: Size(double.infinity, 70),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {
                Get.to(() => PembayaranSuccess());
            },
            child: Text(
              'Bayar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildPaymentMethod({required IconData icon, required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 40, color: Colors.black),
            SizedBox(width: 16),
            Text(title, style: TextStyle(color: Colors.black)),
          ],
        ),
        Radio<String>(
          value: value,
          groupValue: _selectedPaymentMethod,
          onChanged: (newValue) {
            setState(() {
              _selectedPaymentMethod = newValue;
            });
          },
          activeColor: _selectedBackgroundColor,
        ),
      ],
    );
  }
}

class PembayaranSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECD7D7),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset(
              'assets/images/logo.png',
              height: 20,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFECD7D7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              'Pembayaran Anda Telah Selesai',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Terima kasih telah melakukan pembayaran!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.LACAKPESANAN);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF3131),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Lacak Pesanan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.HOME);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF3131),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Kembali',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
