import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:test_thuetro/savepicture/savepicture.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: ItemList(),
  ));
}

class ItemList extends StatelessWidget {
  ItemList({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('Post');
  SampleItem? selectedMenu;

  //_reference.get()  ---> returns Future<QuerySnapshot>
  //_reference.snapshots()--> Stream<QuerySnapshot> -- realtime updates
  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check error
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> items = documents.map((e) => e.data() as Map).toList();

            //Display the list
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  //Get the item at this index
                  Map thisItem = items[index];
                  //REturn the widget for the list items
                  return Container(
                    height: 120,
                    width: 100,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${thisItem['tieu de bai dang']}',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          PopupMenuButton<SampleItem>(
                            initialValue: selectedMenu,
                            // Callback that sets the selected popup menu item.
                            onSelected: (SampleItem item) {
                              (() {
                                selectedMenu = item;
                              });
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<SampleItem>>[
                              const PopupMenuItem<SampleItem>(
                                value: SampleItem.itemOne,
                                child: Text('Chỉnh Sửa'),
                              ),
                              const PopupMenuItem<SampleItem>(
                                value: SampleItem.itemTwo,
                                child: Text('Ẩn Bài Đăng'),
                              ),
                              const PopupMenuItem<SampleItem>(
                                value: SampleItem.itemThree,
                                child: Text('Xoá Bài Đăng'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${thisItem['Thanh Pho']}',
                                style: TextStyle(fontSize: 8),
                              ),
                             
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                '${thisItem['Giachothue']}k/tháng',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Tình trạng: còn phòng',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.purple),
                              ),
                            ],
                          ),
                        ],
                      ),
                      contentPadding: EdgeInsets.zero,
                      isThreeLine: true,
                      leading: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        height: 120,
                        width: 100,
                        child: thisItem.containsKey('image_$index')
                            ? Image.network(
                                '${thisItem['image_$index']}',
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              )
                            : Container(),
                      ),
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => ItemDetails(thisItem['id'])));
                      },
                    ),
                  );
                });
          }

          //Show loader
          return Center(child: CircularProgressIndicator());
        },
      ), //Display a list // Add a FutureBuilder
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
