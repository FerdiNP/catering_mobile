import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Voucher extends StatefulWidget {
  @override
  _VoucherState createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  final List<Map<String, String>> coupons = [
    {
      'code': 'PAGI 123',
      'discount': 'Diskon 30%',
      'description': 'Gunakan kode tersebut agar anda mendapatkan diskon sebesar 30%',
    },
    {
      'code': 'PAGI 345',
      'discount': 'Diskon 20%',
      'description': 'Gunakan kode tersebut agar anda mendapatkan diskon sebesar 20%',
    },
    {
      'code': 'PAGI 6969',
      'discount': 'Diskon 35%',
      'description': 'Gunakan kode tersebut agar anda mendapatkan diskon sebesar 35%',
    },
    {
      'code': 'PAGI 389',
      'discount': 'Diskon 10%',
      'description': 'Gunakan kode tersebut agar anda mendapatkan diskon sebesar 10%',
    },
  ];

  List<Map<String, String>> filteredCoupons = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCoupons = coupons;
  }

  void filterCoupons(String query) {
    setState(() {
      filteredCoupons = coupons.where((coupon) {
        return coupon['code']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E7E4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF5E7E4),
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          'Kupon',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari Kode Kupon',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Color(0xFFFF3131)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                filterCoupons(value);
              },
            ),
            SizedBox(height: 16),

            Text(
              'Kupon Tersedia',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: filteredCoupons.length,
                itemBuilder: (context, index) {
                  final coupon = filteredCoupons[index];
                  return CouponCard(
                    code: coupon['code']!,
                    discount: coupon['discount']!,
                    description: coupon['description']!,
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

class CouponCard extends StatelessWidget {
  final String code;
  final String discount;
  final String description;

  CouponCard({required this.code, required this.discount, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(Icons.local_offer, color: Colors.orange, size: 40),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    discount,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Selengkapnya',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
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
              child: Text('APPLY',
              style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
