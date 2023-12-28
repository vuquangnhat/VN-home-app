import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:test_thuetro/savepicture/item_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: Listviewhorizotal(),
  ));
}

class Listviewhorizotal extends StatefulWidget {
  const Listviewhorizotal({super.key});

  @override
  State<Listviewhorizotal> createState() => _ListviewhorizotalState();
}

class _ListviewhorizotalState extends State<Listviewhorizotal> {
  List<Map> _filteredItems = [];
  Color color2 = Colors.red;
  List<Map> items = [];
  String tinhtrangphong = 'Còn Trống';
  void initState() {
    super.initState();
    featch();
    setState(() {});
  }

  Future<void> featch() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Post').get();

    setState(() {
      items = querySnapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> document) {
        return document.data()!;
      }).toList();
      _filteredItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis
                        .horizontal, // Set the scroll direction to horizontal
                    itemCount: _filteredItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map thisItem = _filteredItems[index];

                      if (thisItem['image_0'] != null &&
                          thisItem['image_0'] is String) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ItemDetails(thisItem['Post ID'])));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Container(
                                  height: 300,
                                  width: 360,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Stack(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 200,
                                        width: 340,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                  0.3), // Màu sắc và độ mờ của đổ bóng
                                              spreadRadius:
                                                  2, // Kích thước đổ bóng
                                              blurRadius:
                                                  5, // Độ nhòe của đổ bóng
                                              offset: Offset(0,
                                                  3), // Độ dời của đổ bóng theo chiều ngang và chiều dọc
                                            ),
                                          ],
                                        ),
                                        child: Image.network(
                                          thisItem['image_0'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 210, left: 10),
                                      child: Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 40,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  253, 236, 239, 1),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                              child: Text(
                                            thisItem['LoaiPhong'],
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    252, 150, 163, 1)),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 260, left: 12),
                                      child: Row(
                                        children: [
                                          Text(
                                            thisItem['tieu de bai dang'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 290, left: 12),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                          Text(
                                            thisItem['Thanh Pho'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 320, left: 13),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text('VND ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Color.fromRGBO(
                                                        104, 170, 251, 1))),
                                          ),
                                          Text(
                                            thisItem['Giachothue'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                color: Colors.black),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 2),
                                            child: Text('Triệu/Tháng',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Colors.grey)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 350, left: 12),
                                      child: Container(
                                        height: 50,
                                        width: 335,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ItemDetails(thisItem[
                                                              'Post ID'])));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromRGBO(
                                                    88, 150, 241, 1),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                            child: Text(
                                              'Chi Tiết',
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      187, 206, 235, 1)),
                                            )),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ));
                      } else {
                     
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
