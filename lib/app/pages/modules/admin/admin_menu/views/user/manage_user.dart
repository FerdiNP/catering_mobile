import 'package:catering_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageUser extends StatefulWidget {
  @override
  _ManageUserState createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  final Color _backgroundColor = Color(0xFFECD7D7);
  final CollectionReference _userCollection = FirebaseFirestore.instance
      .collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed(Routes.HOMEADMIN);
          },
        ),
        title: Text('Daftar User'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(Routes.FORMUSER);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _userCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final userItems = snapshot.data!.docs;

          return ListView.builder(
            itemCount: userItems.length,
            itemBuilder: (context, index) {
              final user = userItems[index];
              final userId = user.id;

              String name = user['name'] ?? 'Nama';
              String username = user['username'] ?? 'Username';
              String email = user['email'] ?? '';
              String role = user['role'] ?? '';

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4, // Menambahkan bayangan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Membulatkan sudut
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16), // Padding lebih besar
                  title: Text(
                    email,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text('Username: ' + username, style: TextStyle(
                          color: Colors.grey[700])),
                      Text('Nama: ' + name, style: TextStyle(color: Colors
                          .grey[700])),
                      Text('Role: ' + role, style: TextStyle(color: Colors
                          .grey[700])),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Get.toNamed(Routes.FORMUSER, arguments: {
                            'userId': userId,
                            'name': user['name'],
                            'username': user['username'],
                            'email': user['email'],
                            'role': user['role'],
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}