import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_thuetro/savepicture/detailpicture.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../chat/screens/all_chat_screen.dart';
import '../component/listview_recomand.dart';
import '../component/listviewmost.dart';
// import 'package:flutterfiredemo/edit_item.dart';

class ItemDetails extends StatefulWidget {
  ItemDetails(this.itemId, {Key? key}) : super(key: key) {
    _reference = FirebaseFirestore.instance.collection('Post').doc(itemId);
    _futureData = _reference.get();
  }

  String itemId;
  late DocumentReference _reference;

  //_reference.get()  --> returns Future<DocumentSnapshot>
  //_reference.snapshots() --> Stream<DocumentSnapshot>
  late Future<DocumentSnapshot> _futureData;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails>
    with SingleTickerProviderStateMixin {
  late Map data;
  late final TabController _tabController;
  List<dynamic> tienich_list = [];
  List<dynamic> image_list = [];
  Map? account_list;
  String tennguoidang = '';
  String kitudau = '';
  String email = '';
  String? userId;
  final String placeName = '30 Phú Lộc 17';
  final TextEditingController hovaten = TextEditingController();
    final _formKey = GlobalKey<FormState>();
  final TextEditingController sdt = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  String getURL(String address) {
    String payload = address.replaceAll(' ', '+');
    return 'https://www.google.com/maps/place/$payload?hl=vi-VN&entry=ttu';
  }

  void openGoogleMapsLink(String address) async {
    String getURL(String address) {
      String payload = address.replaceAll(' ', '+');
      return 'https://www.google.com/maps/place/$payload?hl=vi-VN&entry=ttu';
    }

    try {
      launchUrlString(getURL(address));
      print(getURL(address));
    } catch (err) {}
  }
void incrementSoLanClick(String postId) async {
  try {
    await FirebaseFirestore.instance
        .collection('Post')
        .doc(postId)
        .update({'so lan click': FieldValue.increment(1)});
        
    print('Đã tăng trường so lan click thành công');
  } catch (error) {
    print('Đã xảy ra lỗi khi tăng trường so lan click: $error');
  }
}

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void getInfoIfUserIdExists(String postUserId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Lấy dữ liệu từ collection 'Post' bằng cách sử dụng post id
      DocumentSnapshot postSnapshot =
          await firestore.collection('Post').doc(postUserId).get();

      if (postSnapshot.exists) {
        // Nếu document tồn tại, lấy giá trị user id từ trường 'user id'
        Map<String, dynamic> postData =
            postSnapshot.data() as Map<String, dynamic>;
        setState(() {
           userId = postData['user id'] as String?;
        });
       
        print(userId);
      } else {
        print(
            'Không tìm thấy document có post id là $postUserId trong collection Post.');
        return;
      }
    } catch (e) {
      print('Lỗi khi lấy user id từ post id: $e');
      return;
    }

    // Kiểm tra xem userId có giá trị không trước khi sử dụng nó để truy vấn collection 'Users'
    if (userId != null) {
      try {
        DocumentSnapshot userSnapshot =
            await firestore.collection('Users').doc(userId).get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          userData.forEach((key, value) {
            print('$key: $value');
          });
          account_list = userData;
          setState(() {
            tennguoidang = account_list?['username'] ?? 'Vũ Quang Nhật';
            kitudau = tennguoidang[0];
            email = account_list?['email'] ?? 'vuquangnhat@gmail.com';
            print(tennguoidang);
          });
        } else {
          print('Không tìm thấy user data name');
        }
      } catch (e) {
        print('Lỗi khi lấy user id từ post id: $e');
      }
    } else {
      print('userId là null');
    }
  }

  //list này dùng để lấy dữ liệu array từ firebase
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    gettienichlistfromfirebase();
    get_image_list_from_firebase();
    getInfoIfUserIdExists(widget.itemId);
    incrementSoLanClick(widget.itemId);
    setState(() {
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void gettienichlistfromfirebase() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> value =
          await FirebaseFirestore.instance
              .collection("Post")
              .doc(widget.itemId)
              .get();

      if (value.exists) {
        final dynamic tienichList = value.data()?["tienich_list"];

        if (tienichList != null) {
          // Kiểm tra xem trường "tienich_list" có phải là mảng chuỗi hay không
          if (tienichList is List) {
            tienich_list = List<String>.from(tienichList);
            print(tienich_list);
          } else {
            print("Trường 'tienich_list' không phải là mảng trong tài liệu.");
          }
        } else {
          print("Trường 'tienich_list' là null trong tài liệu.");
        }
      } else {
        print("Tài liệu không tồn tại.");
      }
    } catch (error) {
      print("Lỗi khi lấy dữ liệu: $error");
    }
  }

  void get_image_list_from_firebase() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> value =
          await FirebaseFirestore.instance
              .collection("Post")
              .doc(widget.itemId)
              .get();

      if (value.exists) {
        final dynamic imagelist = value.data()?["imageUrls"];

        if (imagelist != null) {
          // Kiểm tra xem trường "tienich_list" có phải là mảng chuỗi hay không
          if (imagelist is List) {
            image_list = List<String>.from(imagelist);
            print(image_list);
          } else {
            print("Trường 'imageUrls' không phải là mảng trong tài liệu.");
          }
        } else {
          print("Trường 'imageUrls' là null trong tài liệu.");
        }
      } else {
        print("Tài liệu không tồn tại.");
      }
    } catch (error) {
      print("Lỗi khi lấy dữ liệu: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết phòng'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Xử lý khi nhấn nút back
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: widget._futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            //Get the data
            DocumentSnapshot documentSnapshot = snapshot.data;
            data = documentSnapshot.data() as Map;

            //display the data
            return Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        TabBar.secondary(
                          controller: _tabController,
                          tabs: [
                            Tab(
                              child: Text(
                                'Chi Tiết',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Ảnh',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Có thể bạn thích',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                    0.2), // Màu của shadow và độ trong suốt
                                spreadRadius: 2, // Độ mở rộng của shadow
                                blurRadius: 5, // Độ mờ của shadow
                                offset: Offset(0,
                                    2), // Độ dịch chuyển của shadow theo chiều ngang và dọc
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              //content tab1
                              Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Container(
                                      height: 900,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.898)),
                                      child: Stack(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: Container(
                                                height: 200,
                                                width: 370,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        data['image_0']),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 220,
                                            ),
                                            child: Container(
                                                height: 160,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(
                                                              0.1), // Màu của shadow
                                                      spreadRadius:
                                                          2, // Bán kính lan rộng của shadow
                                                      blurRadius:
                                                          5, // Độ mờ của shadow
                                                      offset: Offset(0,
                                                          3), // Độ dịch chuyển của shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8,
                                                                  left: 8),
                                                          child: Text(
                                                            data[
                                                                'tieu de bai dang'],
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Text(
                                                              'Thành Phố: ${data['Thanh Pho']}'),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Text(
                                                              '${data['LoaiPhong']}'),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(left: 8),
                                                          child: Text(
                                                              'Địa Chỉ: ${data['So Nha']} ${data['Ten Duong']}'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 110),
                                                          child: Container(
                                                            height: 30,
                                                            width: 50,
                                                            child: TextButton(
                                                              onPressed: () {
                                                                openGoogleMapsLink(
                                                                    '${data['So Nha']} ${data['Ten Duong']} ${data['Thanh Pho']}');
                                                              },
                                                              child: Text('Tìm'),
                                                            ),
                                                          ),
                                                        )
                                                        // TextButton(onPressed: (){
            
                                                        // }, child: Text('Tìm Đường'))
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5,
                                                                  left: 10),
                                                          child: Text(
                                                              'Giá Cho Thuê: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          104,
                                                                          170,
                                                                          251,
                                                                          1))),
                                                        ),
                                                        Text(
                                                          data['Giachothue'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5,
                                                                  left: 2),
                                                          child: Text(
                                                              'Triệu/Tháng',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 400, left: 0),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(
                                                              0.1), // Màu của shadow
                                                      spreadRadius:
                                                          2, // Bán kính lan rộng của shadow
                                                      blurRadius:
                                                          5, // Độ mờ của shadow
                                                      offset: Offset(0,
                                                          3), // Độ dịch chuyển của shadow
                                                    ),
                                                  ],
                                                ),
                                                width: double.infinity,
                                                height: 150,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(left: 15),
                                                          child: Text(
                                                            'Tiện Ích: ',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    if (tienich_list != null)
                                                      Row(
                                                        children: [
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom: 5,
                                                                      top: 5),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 15),
                                                                child: Text(
                                                                  '-${tienich_list.join(', ')}', // Gộp tất cả các item thành một chuỗi
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  maxLines: 3,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap: true,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(left: 15),
                                                          child: Text(
                                                            'Tiền Điện : ${data['Tiendien']}k/Số',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  top: 3),
                                                          child: Text(
                                                            'Tiền Điện : ${data['tiennuoc']}k/Số',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  top: 5),
                                                          child: Text(
                                                            'Sức Chứa : ${data['SucChua']}người/Phòng',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 570, left: 0),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(
                                                              0.1), // Màu của shadow
                                                      spreadRadius:
                                                          2, // Bán kính lan rộng của shadow
                                                      blurRadius:
                                                          5, // Độ mờ của shadow
                                                      offset: Offset(0,
                                                          3), // Độ dịch chuyển của shadow
                                                    ),
                                                  ],
                                                ),
                                                width: double.infinity,
                                                height: 130,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(left: 15),
                                                          child: Text(
                                                            'Mô Tả Chi Tiết: ',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Flexible(
                                                            child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 15),
                                                          child: Text(
                                                            '-${data['noi dung mo ta']}',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ))
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          ),
            
                                          //
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 710, left: 10, right: 10),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    0.1), // Màu của shadow
                                                spreadRadius:
                                                    2, // Bán kính lan rộng của shadow
                                                blurRadius: 5, // Độ mờ của shadow
                                                offset: Offset(0,
                                                    3), // Độ dịch chuyển của shadow
                                              ),
                                            ],
                                          ),
                                          height: 150,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'Người Đăng Bài',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 50,
                                                    child: CircleAvatar(
                                                      child: Text(
                                                          '${tennguoidang[0].toUpperCase()}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      backgroundColor:
                                                          Colors.blue,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '$tennguoidang',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                right: 11),
                                                        child: Text(
                                                          '$email',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.grey),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 170),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.9), // Màu xám và độ trong suốt
                                                            spreadRadius: 2,
                                                            blurRadius: 5,
                                                            offset: Offset(0, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AllChatScreen()),
                                                          );
                                                        },
                                                        child: const Icon(
                                                          Icons.chat_bubble,
                                                          size: 30,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Container(
                                                  height: 50,
                                                  width: 280,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        data = documentSnapshot
                                                            .data() as Map;
                                                        print(data);
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              Dialog(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Container(
                                                              height: 400,
                                                              width: 400,
                                                              child: Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top: 10,
                                                                          left:
                                                                              110),
                                                                      child: Text(
                                                                        'Đặt Lịch Hẹn',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                13),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top: 30,
                                                                          left:
                                                                              10),
                                                                      child: Text(
                                                                        'Địa Chỉ: ',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                13),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top: 50,
                                                                          left:
                                                                              10),
                                                                      child: Text(
                                                                        '${data['So Nha']} ${data['Ten Duong']}, ${data['Thanh Pho']} ',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .normal,
                                                                            fontSize:
                                                                                13),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top: 80,
                                                                          left:
                                                                              10),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                'HỌ VÀ TÊN ',
                                                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          TextFormField(
                                                                            controller:
                                                                                hovaten,
                                                                            keyboardType:
                                                                                TextInputType.text,
                                                                            decoration: const InputDecoration(
                                                                                border: UnderlineInputBorder(),
                                                                                hintText: 'HỌ VÀ TÊN',
                                                                                hintStyle: TextStyle(color: Colors.grey)),
                                                                            validator:
                                                                                (value) {
                                                                              if (value == null ||
                                                                                  value.isEmpty) {
                                                                                return 'Vui lòng nhập họ và tên';
                                                                              }
                                                                              if (value.length >
                                                                                  30) {
                                                                                return 'Họ và tên không được vượt quá 30 ký tự';
                                                                              }
                                                                              if (RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                                                                                return null;
                                                                              }
                                                                              return 'Chỉ được nhập chữ';
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                'SỐ ĐIỆN THOẠI ',
                                                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          TextFormField(
                                                                            controller:
                                                                                sdt,
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            decoration: const InputDecoration(
                                                                                border: UnderlineInputBorder(),
                                                                                hintText: 'Nhập số điện thoại của bạn',
                                                                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                                                                            validator:
                                                                                (value) {
                                                                              if (value!.isEmpty) {
                                                                                return 'Vui lòng nhập số điện thoại';
                                                                              }
                                                                              if (RegExp(r'^0[0-9]{9}$').hasMatch(value)) {
                                                                                return null;
                                                                              }
                                                                              return 'Số điện thoại không hợp lệ';
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                'NGÀY ĐẶT HẸN ',
                                                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          TextFormField(
                                                                            controller:
                                                                                _dateController,
                                                                            readOnly:
                                                                                true,
                                                                            onTap:
                                                                                () {
                                                                              _selectDate(context);
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          Container(
                                                                              height:
                                                                                  50,
                                                                              width:
                                                                                  200,
                                                                              child:
                                                                                  ElevatedButton(
                                                                                onPressed: () async {
                                                                                  getInfoIfUserIdExists(widget.itemId);
                                                                                  CollectionReference Reservation = FirebaseFirestore.instance.collection('Reservation');
                                                                                  final FirebaseAuth _auth = FirebaseAuth.instance;
                                                                                  await Reservation.doc(widget.itemId)
                                                                                      .set({
                                                                                        'Id nguoi dat': _auth.currentUser!.uid,
                                                                                        'Dia chi': '${data['So Nha']} ${data['Ten Duong']}}',
                                                                                        'Ten nguoi dat': hovaten.text,
                                                                                        'Ngay dat hen' : _dateController.text,
                                                                                        'Id nguoi dang bai': userId,
                                                                                        'Id phong' : widget.itemId
                                                                                      })
                                                                                      .then((value) => print("Success Added userid $userId and selected day : $selectedDate"))
                                                                                      .catchError((error) => print("Failed to add data: $error"))
                                                                                      .whenComplete(() => Navigator.of(context).pop())
                                                                                      ;
                                                                                },
                                                                                child: Text('Đặt Hẹn'),
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20.0), // Điều chỉnh độ bo tròn ở đây
                                                        ),
                                                        elevation:
                                                            5.0, // Điều chỉnh độ đổ bóng ở đây
                                                        shadowColor: Colors
                                                            .grey, // Màu sắc của bóng
                                                      ),
                                                      child: const Text(
                                                        'Đặt Ngày Tới Xem Phòng',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      )),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  )
                                ],
                              ),
            
                              //xu huong
                              Container(
                                color: Colors.white,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        2, // Số lượng cột trên mỗi dòng
                                    crossAxisSpacing:
                                        8.0, // Khoảng cách giữa các cột
                                    mainAxisSpacing:
                                        8.0, // Khoảng cách giữa các dòng
                                  ),
                                  itemCount: image_list.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                                imageUrl: image_list[index]),
                                          ),
                                        );
                                      },
                                      child: Image.network(
                                        image_list[index],
                                        height:
                                            80.0, // Điều chỉnh chiều cao của hình ảnh theo ý muốn
                                        width:
                                            80.0, // Điều chỉnh chiều rộng của hình ảnh theo ý muốn
                                        fit: BoxFit
                                            .cover, // Để hình ảnh nằm trong ô widget
                                      ),
                                    );
                                  },
                                ),
                              ),
                              //de xuat cho ban
                              Container(
                                  height: 500,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(196, 189, 217, 0.2)),
                                  child: Listviewrecomand()),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
