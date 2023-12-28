import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_thuetro/savepicture/detailpicture.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  final String placeName = '30 Phú Lộc 17';

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

  void getInfoIfUserIdExists(String postUserId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String? userId;

    try {
      // Lấy dữ liệu từ collection 'Post' bằng cách sử dụng post id
      DocumentSnapshot postSnapshot =
          await firestore.collection('Post').doc(postUserId).get();

      if (postSnapshot.exists) {
        // Nếu document tồn tại, lấy giá trị user id từ trường 'user id'
        Map<String, dynamic> postData =
            postSnapshot.data() as Map<String, dynamic>;
        userId = postData['user id'] as String?;
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
            return Container(
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
                          borderRadius: BorderRadius.circular(
                              10), // Điều chỉnh giá trị theo ý muốn
                          color: Color.fromRGBO(196, 189, 217, 0.5),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            //content tab1
                            SingleChildScrollView(
                              child: Container(
                                height: 700,
                                decoration: BoxDecoration(
                                    color:
                                        Color.fromRGBO(255, 255, 255, 0.898)),
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
                                              image:
                                                  NetworkImage(data['image_0']),
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
                                            color: Color.fromRGBO(
                                                196, 189, 217, 0.5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
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
                                                        const EdgeInsets.only(
                                                            top: 8, left: 8),
                                                    child: Text(
                                                      data['tieu de bai dang'],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                        const EdgeInsets.only(
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
                                                        const EdgeInsets.only(
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
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Text(
                                                        'Địa Chỉ: ${data['So Nha']} ${data['Ten Duong']}'),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 110),
                                                    child: Container(
                                                      height: 30,
                                                      width: 50,
                                                      child: TextButton(onPressed: (){
                                                        openGoogleMapsLink(placeName);
                                                      },child: Text('Tìm'),),
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
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Text(
                                                        'Giá Cho Thuê: ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            color:
                                                                Color.fromRGBO(
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
                                                        fontSize: 17,
                                                        color: Colors.black),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5, left: 2),
                                                    child: Text('Triệu/Tháng',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                            color:
                                                                Colors.grey)),
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
                                            color: Color.fromRGBO(
                                                196, 189, 217, 0.5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
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
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Text(
                                                      'Tiện Ích: ',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                            style: TextStyle(
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
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Text(
                                                      'Tiền Điện : ${data['Tiendien']}k/Tháng',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15, top: 3),
                                                    child: Text(
                                                      'Tiền Điện : ${data['tiennuoc']}k/Tháng',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15, top: 5),
                                                    child: Text(
                                                      'Sức Chứa : ${data['SucChua']}người/Phòng',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 550, left: 0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color.fromRGBO(
                                                196, 189, 217, 0.5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
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
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Text(
                                                      'Mô Tả Chi Tiết: ',
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
                                                  Flexible(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15),
                                                    child: Text(
                                                      '${data['noi dung mo ta']}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ))
                                                ],
                                              )
                                            ],
                                          )),
                                    ),
                                
                                  ],
                                ),
                              ),
                            ),

                            //xu huong
                                Container(
                            color: Colors.white,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Số lượng cột trên mỗi dòng
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
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
