import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../widget/user_icon.dart';
import 'chat_screen.dart';

class Seach_Friend extends StatefulWidget {

  Seach_Friend({super.key});

  @override
  State<Seach_Friend> createState() => _Seach_FriendState();
}

class _Seach_FriendState extends State<Seach_Friend> {
  List<Map> _filteredItems = [];
  List<Map> items = [];
  final snapShot = FirebaseFirestore.instance.collection('Users').where(
        'email',
        isNotEqualTo: FirebaseAuth.instance.currentUser!.email!,

      );
  
  void initState() {
    super.initState();
    featch ();
  }
  Future<void> featch() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Users').get();

      items = await querySnapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> document) {
        return document.data()!;
      }).toList();
      _filteredItems = items;
    setState(() {
    });
  }


   search(String value) {
    print(value);
  
    setState(() {
      _filteredItems = items
          .where((item) =>
              item['username'] != null &&
              item['username']
                  .toLowerCase()
                  .contains(value.toLowerCase()))
          .toList();
      print('Here: ${_filteredItems.length}');
    });
    print(_filteredItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: TextField(
                      // controller: editingController,
                      onChanged: (value) {
                        search(value);
                        // searchfiler(value);
                      },
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
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search for Items",
                        hintStyle: TextStyle(
                            color: const Color(0xffb2b2b2),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            decorationThickness: 6),
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.black,
                      ),
                    ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(top:90),
                child: ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      Map thisItem = _filteredItems[index];
                      final username = thisItem['username'];
                      String id = thisItem['user id'];
                      String? imageUrl = thisItem['profile_picture'];
              
                      return _buildFriendCard(context, username, id, imageUrl);
                    }),
              ),
            ],
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
