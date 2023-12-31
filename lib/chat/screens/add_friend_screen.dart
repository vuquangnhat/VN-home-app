import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_thuetro/chat/screens/search_friend.dart';


import '../widget/user_icon.dart';
import 'chat_screen.dart';

class AddFriendScreen extends StatelessWidget {
  final snapShot = FirebaseFirestore.instance.collection('Users').where(
        'email',
        isNotEqualTo: FirebaseAuth.instance.currentUser!.email!,
      );

  AddFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Friend",
          style: TextStyle(fontSize: 24),
        ),
        elevation: 0,
         actions: [
            IconButton(
              icon: Icon(Icons.search,size: 30,),
              onPressed: () {
                // Điều hướng đến màn hình tìm kiếm khi người dùng nhấn nút tìm kiếm
                Navigator.push(context, MaterialPageRoute(builder: (context) => Seach_Friend()));
              },
            ),
          ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: snapShot.get(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snap.hasData) {
            return Center(
              child: Text(
                'No users to add',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          final users = snap.data!.docs;
          print(users);
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final username = user['username'];
                String id = user.reference.id;
                String? imageUrl = user['profile_picture'];

                return _buildFriendCard(context, username, id, imageUrl);
              });
        },
      ),
    );
  }

  Widget _buildFriendCard(
    BuildContext context,
    String username,
    String id,
    String? imageUrl,
  ) {
    return Card(
      child: ListTile(
        leading: UserIcon(size: 25, imageUrl: imageUrl),
        title: Text(username, style: Theme.of(context).textTheme.bodyLarge),
        onTap: () {
            Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(title: username, id: id)),
                      );
        },
      ),
    );
  }
}
