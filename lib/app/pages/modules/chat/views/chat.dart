// chat_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreenView extends StatefulWidget {
  final String otherUserId;

  const ChatScreenView({Key? key, required this.otherUserId}) : super(key: key);

  @override
  _ChatScreenViewState createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  late CollectionReference _messagesCollection;
  late Future<String> _otherUserNameFuture;

  @override
  void initState() {
    super.initState();
    _messagesCollection = FirebaseFirestore.instance.collection('messages');
    _otherUserNameFuture = _getOtherUserName();
  }

  Future<String> _getOtherUserName() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.otherUserId)
        .get();

    final userData = userDoc.data() as Map<String, dynamic>;
    return userData['name'] ?? 'Unknown User';
  }

  void _sendMessage(String senderId, String receiverId) async {
    if (_controller.text.isNotEmpty) {
      try {
        await _messagesCollection.add({
          'message': _controller.text,
          'timestamp': FieldValue.serverTimestamp(),
          'sender': senderId,
          'receiver': receiverId,
        });

        _controller.clear();
        _scrollToBottom();
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECD7D7),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFECD7D7),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: FutureBuilder<String>(
              future: _otherUserNameFuture,
              builder: (context, snapshot) {
                String appBarTitle = 'Chat';
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    appBarTitle = 'Chat with ${snapshot.data}';
                  } else {
                    appBarTitle = 'Chat with Unknown User';
                  }
                }

                return AppBar(
                  scrolledUnderElevation: 0,
                  title: Text(appBarTitle),
                  backgroundColor: Color(0xFFECD7D7),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  elevation: 0,
                );
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesCollection
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No messages yet"));
                }

                var messages = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return (data['sender'] == currentUserId &&
                      data['receiver'] == widget.otherUserId) ||
                      (data['sender'] == widget.otherUserId &&
                          data['receiver'] == currentUserId);
                }).toList();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                });

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var messageData =
                    messages[index].data() as Map<String, dynamic>;
                    bool isMe = messageData['sender'] == currentUserId;

                    return Align(
                      alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        margin:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Color(0xFFFF3131)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          messageData['message'] ?? '',
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                    ),
                    onSubmitted: (_) => _sendMessage(currentUserId,
                        widget.otherUserId), // Send message on enter
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(
                      currentUserId, widget.otherUserId),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
