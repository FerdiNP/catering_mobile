// chat_list_screen.dart
import 'package:catering_mobile/app/pages/modules/chat/views/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFECD7D7),
        elevation: 0,
      ),
      backgroundColor: Color(0xFFECD7D7),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No chats available.', style: TextStyle(fontSize: 18, color: Colors.grey)));
          }

          final users = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return ChatUser(
              id: doc.id,
              name: data['name'] ?? 'Unknown',
              avatarUrl: data['avatarUrl'],
            );
          }).toList();

          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: users.length,
            itemBuilder: (context, index) {
              if (users[index].id == currentUserId) {
                return Container();
              }

              return _buildChatTile(context, users[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildChatTile(BuildContext context, ChatUser user) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreenView(otherUserId: user.id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              backgroundImage: user.avatarUrl != null
                  ? NetworkImage(user.avatarUrl!)
                  : null,
              child: user.avatarUrl == null
                  ? Icon(Icons.person, color: Colors.grey[600], size: 32)
                  : null,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                user.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}

class ChatUser {
  final String id;
  final String name;
  final String? avatarUrl;

  ChatUser({
    required this.id,
    required this.name,
    this.avatarUrl,
  });
}
