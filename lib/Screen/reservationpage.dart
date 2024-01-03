import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../savepicture/item_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ReservationPage(),
  ));
}

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  List<Map> _filteredItems = [];
  List<Map> items = [];
  List<Map> item_post = [];
  List<Map> information_Post = [];
  bool isVisible = true;
  void initState() {
    super.initState();
    featch();
  }

  Future<void> featch() async {
     final FirebaseAuth _auth = FirebaseAuth.instance;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Reservation')
        .where('Id nguoi dang bai', isEqualTo: _auth.currentUser!.uid)
        .get();

    items = await querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> document) {
      return document.data()!;
    }).toList();
    _filteredItems = items;
    print(_filteredItems);

    String postid = '${_filteredItems[0]['Id phong']}';
    QuerySnapshot<Map<String, dynamic>> querySnapshot_post =
        await FirebaseFirestore.instance
            .collection('Post')
            .where('Post ID', isEqualTo: postid)
            .get();
    item_post = await querySnapshot_post.docs
        .map((DocumentSnapshot<Map<String, dynamic>> document) {
      return document.data()!;
    }).toList();
    information_Post = item_post;
    print('thong tin Post $information_Post');
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
                    scrollDirection:
                        Axis.vertical, // Set the scroll direction to vertical
                    itemCount: _filteredItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map thisItem = information_Post[index];
                      Map user_reservation = _filteredItems[index];

                      if (thisItem['image_0'] != null &&
                          thisItem['image_0'] is String) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ItemDetails(user_reservation['Id phong'])));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible: isVisible,
                                child: Stack(
                                  children: [
                                    Text('Các Phòng Đã Được Đặt ',style: TextStyle(fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25),
                                      child: Card(
                                        child: Container(
                                          height: 570,
                                          width: 360,
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromARGB(255, 255, 255, 255),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Stack(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 10),
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
                                                  top: 220, left: 10),
                                              child: Expanded(
                                                flex: 2,
                                                child: Container(
                                                  height: 40,
                                                  width: 140,
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
                                                  top: 270, left: 12),
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
                                                  top: 300, left: 12),
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
                                                  top: 330, left: 13),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(top: 5),
                                                    child: Text('VND ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                            color: Colors.grey)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 370, left: 46),
                                              child: Container(
                                                height: 50,
                                                width: 335,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(30)),
                                                child: Text(
                                                  'Thông Tin Người Đặt Phòng',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 410, left: 12),
                                              child: Container(
                                                height: 300,
                                                width: 335,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(30)),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Tên Người Đặt : ${user_reservation['Ten nguoi dat']}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        'Nơi Hẹn Gặp : ${user_reservation['Dia chi'].toUpperCase()}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        'Ngày Tới Xem Phòng : ${user_reservation['Ngay dat hen']}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder:
                                                              (BuildContext context) {
                                                            return AlertDialog(
                                                              content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize.min,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .check_circle,
                                                                    color:
                                                                        Colors.green,
                                                                    size: 48,
                                                                  ),
                                                                  SizedBox(
                                                                      height: 16),
                                                                  Text(
                                                                    'Đã xác nhận gặp mặt',
                                                                    style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              actions: [
                                                                Center(
                                                                  child: ElevatedButton(
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                      setState(() {
                                                                        isVisible = false;
                                                                      }); // Đóng dialog khi nút được nhấn
                                                                    },
                                                                    child: Text('OK'),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child:
                                                          Text('Xác Nhận Đã Gặp Mặt'),
                                                      style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.0), // Đặt bán kính bo tròn
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      } else {
                        return ListTile(
                          title: Text(
                            "No Image Available",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
