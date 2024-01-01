import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rxdart/rxdart.dart';
import 'package:test_thuetro/chat/screens/add_friend_screen.dart';
import 'package:test_thuetro/chat/screens/search_friend.dart';

import '../models/friend.dart';
import '../widget/user_icon.dart';
import 'chat_screen.dart';

class AllChatScreen extends StatefulWidget {
  const AllChatScreen({super.key});

  @override
  State<AllChatScreen> createState() => _AllChatScreenState();
}

class _AllChatScreenState extends State<AllChatScreen> {
  int activeIndex = 0;

  final String user1_id = FirebaseAuth.instance.currentUser!.uid;
  late Query<Map<String, dynamic>> query1;
  List<Map> _filteredItems = [];
  List<Map> items = [];
  // late Stream<QuerySnapshot<Map<String, dynamic>>> query2;

  List<Friend> friends = [];

  @override
  void initState() {
    super.initState();

    featch().whenComplete(() => fliter);
  }

  Future<void> featch() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('friends').get();

    items = await querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> document) {
      return document.data()!;
    }).toList();
    _filteredItems = items;
    setState(() {
      print('du lieu friend $_filteredItems');
    });
  }

  Future<void> fliter() async {
    String uid = user1_id;
    _filteredItems.where((element) => element['user2'] != uid).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 75, left: 25),
              child: Container(
                height: 45,
                width: 340,
                child: TextField(
                  style: TextStyle(
                    color: const Color(0xff020202),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xfff1f1f1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Tìm Kiếm",
                    hintStyle: TextStyle(
                        color: const Color(0xffb2b2b2),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        decorationThickness: 6),
                    prefixIcon: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Seach_Friend()),
                        );
                      },
                      child: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                    prefixIconColor: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 27, left: 30),
              child: Text(
                'Đoạn Chat',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100, right: 10, left: 10),
              child: ListView.builder(
                  itemCount: _filteredItems.length,
                  itemBuilder: (context, index) {
                    final friendDoc = _filteredItems[index];
                    final user2 = friendDoc['user2'];
                    final friendId = user2;
                    final friendName = friendDoc['name2'];
                    final lastMsg = friendDoc['lastMsg'] ?? ' ';
                    final sender = (friendDoc['sender'] == user2);
                    final imageUrl = friendDoc['profile_picture'];

                    return _buildChat(
                      context,
                      lastMsg,
                      friendName,
                      friendId,
                      sender,
                      imageUrl,
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Seach_Friend()),
          );
          print(user1_id);
          print(query1);
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildChat(
    BuildContext context,
    String lastMsg,
    String name,
    String id,
    bool friend,
    String imageUrl,
  ) {
    String sender = (friend) ? name.split(' ')[0] : 'You';

    return Card(
      child: ListTile(
        title: Text(
          name,
          style: Theme.of(context).textTheme.bodyLarge,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          '$sender: $lastMsg',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: (friend) ? Colors.grey[600] : null,
            fontWeight: (friend) ? FontWeight.bold : null,
          ),
        ),
        leading: UserIcon(size: 25, imageUrl: imageUrl),
        // tileColor: Colors.orange,
        shape: const UnderlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 245, 245, 245), width: 2),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(title: name, id: id),
            ),
          );
        },
      ),
    );
  }

  _getFriendImage(String id) async {
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();
    var userData = user.data();
    return userData!['profile_picture'];
  }

  Stream<List<QueryDocumentSnapshot>> _getFriendStream() {
    final query1 = FirebaseFirestore.instance
        .collection('friends')
        .where('user1', isEqualTo: user1_id)
        .orderBy('lastChatTimestamp', descending: true)
        .snapshots();

    final query2 = FirebaseFirestore.instance
        .collection('friends')
        .where('user2', isEqualTo: user1_id)
        .orderBy('lastChatTimestamp', descending: true)
        .snapshots();

    final BehaviorSubject<List<QueryDocumentSnapshot>> _friendsSubject =
        BehaviorSubject<List<QueryDocumentSnapshot>>();

    query1.listen((querySnapshot1) {
      final List<QueryDocumentSnapshot> docs1 = querySnapshot1.docs;
      query2.listen((querySnapshot2) {
        final List<QueryDocumentSnapshot> docs2 = querySnapshot2.docs;
        _friendsSubject.add([...docs1, ...docs2]);
      });
    });

    return _friendsSubject.stream;
  }
}
