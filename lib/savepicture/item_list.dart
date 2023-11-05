import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_thuetro/savepicture/item_details.dart';

import 'package:test_thuetro/savepicture/savepicture.dart';
import 'package:test_thuetro/test/search.dart';

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
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
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
                    // return Container(
                    //   height: 120,
                    //   width: 100,
                    //   color: Colors.amber,
                    //   margin: EdgeInsets.only(bottom: 10),
                    //   child: ListTile(
                    //     title: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           '${thisItem['tieu de bai dang']}',
                    //           style: TextStyle(
                    //               fontSize: 12, fontWeight: FontWeight.bold),
                    //         ),
                    //         PopupMenuButton<SampleItem>(
                    //           initialValue: selectedMenu,
                    //           // Callback that sets the selected popup menu item.
                    //           onSelected: (SampleItem item) {
                    //             (() {
                    //               selectedMenu = item;
                    //             });
                    //           },
                    //           itemBuilder: (BuildContext context) =>
                    //               <PopupMenuEntry<SampleItem>>[
                    //             const PopupMenuItem<SampleItem>(
                    //               value: SampleItem.itemOne,
                    //               child: Text('Chỉnh Sửa'),
                    //             ),
                    //             const PopupMenuItem<SampleItem>(
                    //               value: SampleItem.itemTwo,
                    //               child: Text('Ẩn Bài Đăng'),
                    //             ),
                    //             const PopupMenuItem<SampleItem>(
                    //               value: SampleItem.itemThree,
                    //               child: Text('Xoá Bài Đăng'),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //     subtitle: Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Text(
                    //               '${thisItem['Thanh Pho']}',
                    //               style: TextStyle(fontSize: 8),
                    //             ),
        
                    //           ],
                    //         ),
                    //         SizedBox(height: 10,),
                    //         Row(
                    //           children: [
                    //             Text(
                    //               '${thisItem['Giachothue']}k/tháng',
                    //               style: TextStyle(
                    //                   fontSize: 12,
                    //                   color: Colors.purple,
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //           ],
                    //         ),
                    //         Row(
                    //           children: [
                    //             Text(
                    //               'Tình trạng: còn phòng',
                    //               style: TextStyle(
                    //                   fontSize: 12, color: Colors.purple),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //     contentPadding: EdgeInsets.zero,
                    //     isThreeLine: true,
                    //     // leading: Container(
        
                    //     //   decoration: BoxDecoration(
                    //     //      color: Colors.white,
                    //     //       // borderRadius: BorderRadius.circular(30)
                    //     //       ),
                    //     //   width: 100,
                    //     //   child: thisItem.containsKey('image_$index')
                    //     //       ? Image.network(
                    //     //           '${thisItem['image_$index']}',
                    //     //           fit: BoxFit.cover,
                    //     //           filterQuality: FilterQuality.high,
                    //     //         )
                    //     //       : Container(),
                    //     // ),
                    //     leading: SizedBox(child: thisItem.containsKey('image_$index')
                    //           ? Image.network(
                    //               '${thisItem['image_$index']}',
                    //               fit: BoxFit.cover,
                    //               height: 200,
                    //               width: 250,
                    //             ):SizedBox(height: 200,width: 250,)),
        
                    //     trailing: Icon(Icons.more_vert),
                    //     onTap: () {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //           builder: (context) => ItemDetails(thisItem['Post ID'])));
                    //     },
                    //   ),
                    // );
                    if (thisItem['image_$index'] != null && thisItem['image_$index'] is String) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(thisItem['image_$index']),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                            
                              decoration: BoxDecoration(
                                color: Colors.yellow[700],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              width: 100,
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: Center(
                                child: Text(
                                  '${thisItem['LoaiPhong']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${thisItem['tieu de bai dang']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                       '${thisItem['Giachothue']}/Tháng',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          '${thisItem['Thanh Pho']}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Icon(
                                          Icons.zoom_out_map,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          '${thisItem['DienTich']} m2',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow[700],
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          " Reviews",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                    };
                  });
            }
        
            //Show loader
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
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
