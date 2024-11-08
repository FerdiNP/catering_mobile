import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class StatusPengiriman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        primaryColor: Color(0xFFFF3131),
        scaffoldBackgroundColor: Color(0xFFECD7D7),
      ),
      home: StatusPengirimanView(),
    );
  }
}

class StatusPengirimanView extends StatefulWidget {
  @override
  _StatusPengirimanViewState createState() => _StatusPengirimanViewState();
}

class _StatusPengirimanViewState extends State<StatusPengirimanView> {
  LatLng _courierLocation = LatLng(-6.200000, 106.816666);
  double _zoomLevel = 14.0;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECD7D7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFECD7D7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Status Pengiriman',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _courierLocation,
                    initialZoom: _zoomLevel,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _courierLocation,
                          child: Icon(
                            Icons.local_shipping,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: 20,
                  right: 10,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: "zoomIn",
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            _zoomLevel++;
                            _mapController.move(_courierLocation, _zoomLevel);
                          });
                        },
                        child: Icon(Icons.zoom_in, color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      FloatingActionButton(
                        heroTag: "zoomOut",
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            _zoomLevel--;
                            _mapController.move(_courierLocation, _zoomLevel);
                          });
                        },
                        child: Icon(Icons.zoom_out, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue[100],
                        child: Icon(Icons.person, size: 35, color: Colors.blue),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pelanggan : ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'Jane Doe',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      _buildActionButton(Icons.chat, Colors.blueAccent),
                      SizedBox(width: 10),
                      _buildActionButton(Icons.phone, Colors.green),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  _buildTransactionDetails(),
                  Spacer(),
                  _buildCheckStatusButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.1),
      ),
      child: IconButton(
        icon: Icon(icon, size: 30, color: color),
        onPressed: () {
          if (icon == Icons.chat) {
            Get.toNamed(Routes.CHAT);
          } else if (icon == Icons.phone) {

          }
        },
      ),
    );
  }

  Widget _buildTransactionDetails() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Detail Pengiriman',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        _buildDetailRow('Alamat Pengiriman', 'Jl. Contoh No. 123'),
        _buildDetailRow('Estimasi Waktu', '30 Menit'),
        Divider(),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Spacer(),
        Center(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckStatusButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showConfirmationDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF3131),
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        child: Text(
          'Selesaikan Pengiriman',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pengiriman'),
          content: Text('Apakah Anda yakin pengiriman telah selesai?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Get.offAllNamed(Routes.HOMEKURIR);
                Get.snackbar('Pengiriman Dikonfirmasi', 'Pengiriman telah selesai.');
              },
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }
}
