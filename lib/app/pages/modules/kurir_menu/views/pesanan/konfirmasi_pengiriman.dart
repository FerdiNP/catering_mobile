import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePengiriman extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? deliveryStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Pengiriman'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Isi detail konfirmasi pengiriman:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status Pengiriman'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Silakan masukkan status pengiriman';
                  }
                  return null;
                },
                onSaved: (value) {
                  deliveryStatus = value;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Get.back();
                    Get.snackbar('Pengiriman Dikonfirmasi', 'Status: $deliveryStatus');
                  }
                },
                child: Text('Konfirmasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
