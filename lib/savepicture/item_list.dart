import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_thuetro/component/listviewpost.dart';
import 'package:test_thuetro/component/listviewsearch.dart';
import 'package:test_thuetro/savepicture/savepicture.dart';

import '../component/listviewitem.dart';
enum SampleItem { itemOne, itemTwo, itemThree }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     color: Colors.white,
//     home: ItemList(),
//   ));
// }

class ItemList extends StatefulWidget {
  ItemList({Key? key}) : super(key: key) {}

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late CollectionReference _reference;
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _reference = FirebaseFirestore.instance.collection('Post');
    _stream = _reference.snapshots();
  }

  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Title'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Searchcustom()));
              // Handle the search result if needed
            },
          ),
        ],
      ),
      body: ListviewPost(),
      //Display a list // Add a FutureBuilder
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddItem()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Searchcustom extends StatefulWidget {
  const Searchcustom({super.key});

  @override
  State<Searchcustom> createState() => _SearchcustomState();
}

class _SearchcustomState extends State<Searchcustom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listviewitem(),
    );
  }
}
