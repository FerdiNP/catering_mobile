import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final FlutterCart cart = FlutterCart();

  void increaseItem(String productId, List<ProductVariant> variants) {
    int index = cart.getProductIndex(productId, variants);

    if (index != -1) {
      setState(() {
        int currentQuantity = cart.cartItemsList[index].quantity;
        int newQuantity = currentQuantity + 1;

        cart.updateQuantity(productId, variants, newQuantity);
      });

      Get.snackbar(
        "Jumlah Ditambah",
        "Jumlah item berhasil ditambah",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(milliseconds: 1000),
      );
    }
  }

  void decreaseItem(String productId, List<ProductVariant> variants) {
    int index = cart.getProductIndex(productId, variants);

    if (index != -1) {
      setState(() {
        if (cart.cartItemsList[index].quantity > 1) {
          cart.updateQuantity(productId, variants, cart.cartItemsList[index].quantity - 1);
          Get.snackbar(
            "Jumlah Dikurangi",
            "Jumlah item berhasil dikurangi",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
            duration: Duration(milliseconds: 1000),
          );
        } else {
          // Jika quantity = 1, hapus item
          cart.removeItem(productId, variants);
          Get.snackbar(
            "Item Dihapus",
            "Item telah dihapus dari keranjang",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(milliseconds: 1000),
          );
        }
      });
    }
  }

  void removeItem(String productId, List<ProductVariant> variants) {
    int index = cart.getProductIndex(productId, variants);

    if (index != -1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Konfirmasi Hapus"),
            content: Text("Apakah Anda yakin ingin menghapus item ini dari keranjang?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Batal"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    cart.removeItem(productId, variants);
                  });

                  Get.snackbar(
                    "Item Dihapus",
                    "Item berhasil dihapus dari keranjang",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    duration: Duration(milliseconds: 1000),
                  );

                  Navigator.of(context).pop();
                },
                child: Text("Hapus"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _unselectedBackgroundColor = Color(0xFFECD7D7);

    return Scaffold(
      backgroundColor: Color(0xFFECD7D7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'KERANJANG',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: cart.cartItemsList.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'Keranjang Anda Kosong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Tambahkan produk ke keranjang untuk mulai belanja.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 90.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.ALAMATPENGIRIMAN);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                backgroundColor: _unselectedBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black),
                ),
                elevation: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilih Alamat',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cart.cartItemsList.length,
              itemBuilder: (context, index) {
                final item = cart.cartItemsList[index];
                final productMeta = item.productMeta as Map<String, dynamic>;
                final imageUrl = productMeta['gambarMenu'] ?? '';

                return Column(
                  children: [
                    _buildCartItem(
                      imageUrl: imageUrl,
                      title: item.productName,
                      time: '20 min',
                      price: NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(item.variants?[0].price ?? 0),
                      quantity: item.quantity,
                      onAdd: () => increaseItem(
                        item.productId ?? '',
                        item.variants ?? [],
                      ),
                      onRemove: () => decreaseItem(
                        item.productId ?? '',
                        item.variants ?? [],
                      ),
                      onDelete: () => removeItem(
                        item.productId ?? '',
                        item.variants ?? [],
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.VOUCHER);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                backgroundColor: _unselectedBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black),
                ),
                elevation: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Masukkan Kode Promo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sub Total',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(cart.subtotal ?? 0),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Diskon',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        'Rp 0',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.grey),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(cart.total ?? 0),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomSheet: cart.cartItemsList.isNotEmpty
          ? Container(
        height: 70,
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF3131),
              padding: EdgeInsets.all(0),
              minimumSize: Size(double.infinity, 70),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {
              Get.toNamed(Routes.PEMBAYARAN);
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
      )
          : null,
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildCartItem({
    required String imageUrl,
    required String title,
    required String time,
    required String price,
    required int quantity,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
    required VoidCallback onDelete,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: imageUrl.isNotEmpty
                ? Image.network(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/placeholder.png?alt=media&token=cb0b15db-a5cc-41fe-9739-66974e62c982',
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                );
              },
            )
                : Image.asset(
              'https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/placeholder.png?alt=media&token=cb0b15db-a5cc-41fe-9739-66974e62c982',
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      price,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: onRemove,
                icon: Icon(Icons.remove_circle_outline),
              ),
              Text(
                quantity.toString(),
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: onAdd,
                icon: Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
