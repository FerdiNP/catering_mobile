import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusPesanan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E7E4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF5E7E4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Status Pemesanan',
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
            SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  OrderStatusItem(
                    icon: Icons.local_fire_department,
                    status: 'Pesanan sedang dimasak',
                    description: 'Kami sedang memasak pesanan Anda.',
                    isCompleted: true,
                  ),
                  OrderStatusItem(
                    icon: Icons.inventory,
                    status: 'Pesanan sedang dibungkus',
                    description: 'Pesanan Anda sedang dibungkus.',
                    isCompleted: true,
                  ),
                  OrderStatusItem(
                    icon: Icons.delivery_dining,
                    status: 'Pesanan dalam perjalanan',
                    description: 'Pesanan Anda dalam perjalanan.',
                    isCompleted: false,
                  ),
                  OrderStatusItem(
                    icon: Icons.check_circle,
                    status: 'Pesanan telah sampai',
                    description: 'Pesanan Anda telah sampai.',
                    isCompleted: false,
                  ),
                ],
              ),
            ),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showReviewDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'Kasih Ulasan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class OrderStatusItem extends StatelessWidget {
  final IconData icon;
  final String status;
  final String description;
  final bool isCompleted;

  OrderStatusItem({
    required this.icon,
    required this.status,
    required this.description,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.black,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : Colors.grey,
            size: 30,
          ),
        ],
      ),
    );
  }
}

void _showReviewDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Tulis Ulasan'),
        content: ReviewDialogContent(),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.HOME);
            },
            child: Text('Kirim'),
          ),
        ],
      );
    },
  );
}

class ReviewDialogContent extends StatefulWidget {
  @override
  _ReviewDialogContentState createState() => _ReviewDialogContentState();
}

class _ReviewDialogContentState extends State<ReviewDialogContent> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  _rating = index + 1;
                });
              },
            );
          }),
        ),
        SizedBox(height: 10),
        Text(
          "Apakah anda puas?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _commentController,
          decoration: InputDecoration(
            hintText: 'Tulis komentar...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
          ),
          maxLines: 3,
        ),
      ],
    );
  }
}
