import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FlutterCart cart = FlutterCart();
  final _mainColor = Color(0xFFECD7D7);

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
      // Show a confirmation dialog before removing the item
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Konfirmasi Hapus"),
            content: Text("Apakah Anda yakin ingin menghapus item ini dari keranjang?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // If the user cancels, close the dialog
                  Navigator.of(context).pop();
                },
                child: Text("Batal"),
              ),
              TextButton(
                onPressed: () {
                  // If the user confirms, remove the item and close the dialog
                  setState(() {
                    cart.removeItem(productId, variants);
                  });

                  // Show snackbar notification
                  Get.snackbar(
                    "Item Dihapus",
                    "Item berhasil dihapus dari keranjang",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    duration: Duration(milliseconds: 1000),
                  );

                  // Close the dialog after removal
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
    return Scaffold(
      backgroundColor: _mainColor,
      appBar: AppBar(
        title: Text('Keranjang', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: _mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: cart.cartItemsList.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'Keranjang Kosong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: cart.cartItemsList.length,
              itemBuilder: (context, index) {
                final item = cart.cartItemsList[index];
                final productMeta = item.productMeta as Map<String, dynamic>;

                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Menu Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: productMeta['gambarMenu'].isEmpty
                              ? Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/catering-23ce0.appspot.com/o/placeholder.png?alt=media&token=cb0b15db-a5cc-41fe-9739-66974e62c982',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                              : Image.network(
                            productMeta['gambarMenu'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),
                        // Menu Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productName ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                NumberFormat.currency(
                                  locale: 'id_ID',
                                  symbol: 'Rp ',
                                  decimalDigits: 0,
                                ).format(item.variants?[0].price ?? 0),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF3131),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove, color: Colors.white),
                                          onPressed: () => decreaseItem(
                                            item.productId ?? '',
                                            item.variants ?? [],
                                          ),
                                        ),

                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(
                                            '${item.quantity}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add, color: Colors.white),
                                          onPressed: () => increaseItem(
                                            item.productId ?? '',
                                            item.variants ?? [],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline, color: Colors.red),
                                    onPressed: () => removeItem(
                                      item.productId ?? '',
                                      item.variants ?? [],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Total and Checkout Button
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(cart.total),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF3131),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF3131),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: cart.cartItemsList.isEmpty
                        ? null
                        : () {
                      // Implement checkout logic here
                    },
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}