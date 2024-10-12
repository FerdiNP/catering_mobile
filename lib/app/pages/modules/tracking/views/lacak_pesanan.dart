import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class LacakPesanan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        primaryColor: Color(0xFFFF3131),
        scaffoldBackgroundColor: Color(0xFFECD7D7),
      ),
      home: LacakPesananView(),
    );
  }
}

class LacakPesananView extends StatefulWidget {
  @override
  _LacakPesananViewState createState() => _LacakPesananViewState();
}

class _LacakPesananViewState extends State<LacakPesananView> {
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
            Get.toNamed('/home');
          },
        ),
        title: Text(
          'Lacak Pesanan',
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
                            color: Colors.green,
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
                        backgroundColor: Colors.green[100],
                        child: Icon(Icons.person, size: 35, color: Colors.green),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Kurir',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Kurir dalam perjalanan',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      _buildActionButton(Icons.chat, Colors.blueAccent, () {
                        Get.toNamed(Routes.CHAT);
                      }),
                      SizedBox(width: 10),
                      _buildActionButton(Icons.phone, Colors.green, () {
                      }),
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

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.1),
      ),
      child: IconButton(
        icon: Icon(icon, size: 30, color: color),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildTransactionDetails() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Detail Transaksi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        _buildDetailRow('Harga Asli', 'Rp 70,000'),
        _buildDetailRow('Diskon', 'Rp 20,000'),
        Divider(),
        _buildDetailRow('Total Pembayaran', 'Rp 50,000', isTotal: true),
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
          Get.toNamed(Routes.STATUSPESANAN);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF3131),
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        child: Text(
          'Cek Status',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
