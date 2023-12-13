import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_thuetro/savepicture/detailpicture.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // void getinformationaccount(String documentKey) async {
  //   // Khởi tạo Firestore
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   try {
  //     // Lấy dữ liệu từ Firestore bằng cách sử dụng document key
  //     DocumentSnapshot documentSnapshot = await firestore
  //         .collection('Post')
  //         .doc(widget.itemId)
  //         .get();

  //     // Kiểm tra xem có dữ liệu không
  //     if (documentSnapshot.exists) {
  //       // Lấy dữ liệu từ document
  //       Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  //       if(data.containsKey('user id')) {
  //          print('Trường user id tồn tại trong document với key ${widget.itemId}');
  //       }else{
  //         print('khong ton tai truong nay');
  //       }

  //       // Xử lý dữ liệu theo ý muốn
  //       // print('Dữ liệu từ Firestore: ${account_list['Name']}adadadad');
  //     } else {
  //       print('Không tìm thấy dữ liệu với key: $documentKey');
  //     }
  //   } catch (e) {
  //     print('Lỗi khi lấy dữ liệu từ Firestore: $e');
  //   }
  // }
  void compareUserIds(String documentKey) async {
    // Khởi tạo Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String postUserId = '';
    try {
      // Lấy dữ liệu từ collection 'Post' bằng cách sử dụng document key
      DocumentSnapshot postSnapshot =
          await firestore.collection('Post').doc(widget.itemId).get();

      // Kiểm tra xem document trong collection 'Post' có tồn tại không
      if (postSnapshot.exists) {
        // Lấy dữ liệu từ document trong collection 'Post'
        Map<String, dynamic> postData =
            postSnapshot.data() as Map<String, dynamic>;
        // print(postData['user id']);
        // Lấy giá trị trường 'userid' từ document trong collection 'Post'
        if (postData.containsKey('user id') && postData['user id'] != null) {
          postUserId = postData['user id'];
        } else {
          print(
              'Giá trị của user id là null hoặc không tồn tại trong postData.');
        }

        // Lấy dữ liệu từ collection 'Users' bằng cách sử dụng userid từ collection 'Post'
        DocumentSnapshot documentSnapshot =
            await firestore.collection('Users').doc(documentKey).get();
        Map<String, dynamic> Useridaccount =
            documentSnapshot.data() as Map<String, dynamic>;
        String Usersid = documentSnapshot['user id'];
        if (postUserId == Usersid) {
          print('2 truong nay giong nhai');
          setState(() {
            account_list = Useridaccount;
            print(account_list?['Name']);
            tennguoidang = account_list?['Name'];
          });
        } else {
          print('2 truong nay khac nhau');
          print('post user id: $postUserId');
          print('Users id: $Usersid');
        }
      } else {
        print('Không tìm thấy document trong collection Post với key:');
      }
    } catch (e) {
      print('Lỗi khi so sánh userid trong Firestore: $e');
    }
  }

  //list này dùng để lấy dữ liệu array từ firebase
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    gettienichlistfromfirebase();
    get_image_list_from_firebase();
    compareUserIds('${_auth.currentUser?.uid}');
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
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(data['image_0']),
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
                                  '${data['LoaiPhong']}',
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
                                      '${data['tieu de bai dang']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${data['Giachothue']}/Tháng',
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
                                          '${data['Thanh Pho']}',
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
                                          '${data['DienTich']} m2',
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Loai phong
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Text('${data['LoaiPhong']}',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 7, 133, 235),
                                          fontWeight: FontWeight.bold)))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              '${data['LoaiPhong']}',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 9, 8, 8),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              'Thành Phố : ${data['Thanh Pho']}, Diện Tích: ${data['DienTich']} m2',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //tabs view
                    SizedBox(
                      height: 10,
                    ),
                    TabBar(
                      controller: _tabController,
                      tabs: [
                        SingleChildScrollView(
                          child: Tab(
                            child: Text(
                              'About',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Review',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Content for Tab 1
                          SingleChildScrollView(
                            child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Tiện ích :',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          if (tienich_list != null)
                                            for (String item in tienich_list)
                                              Text(
                                                '$item, ',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                              ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 13, top: 10),
                                          child: Text(
                                            'Mô tả chi tiết',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //mo ta chi tiet
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13, top: 10),
                                      child: Container(
                                        width: double
                                            .infinity, // Cho phép Text tự động xuống dòng khi không có đủ không gian
                                        child: Text(
                                          ' ${data['noi dung mo ta']}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                    // tai khoan dang bai
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 13, top: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 350,
                                                height:
                                                    50, // You can adjust the height as needed
                                                child: Center(
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                        child: Text('V')),
                                                    title: Text(tennguoidang),
                                                    subtitle: Text('Chủ Trọ'),
                                                    trailing: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Icon(Icons.chat,
                                                            color: Colors.blue),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Icon(Icons.call,
                                                            color: Colors.blue),
                                                        // Add more icons or widgets as needed
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 13, top: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Địa Chỉ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor:
                                                      Color.fromARGB(
                                                          255, 2, 136, 246),
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  textStyle: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  print(account_list?['Name'] ??
                                                      'Vũ Quang Nhật');
                                                },
                                                child: const Text('Bản Đồ'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Center(
                                            child: const Text(
                                          '____________________________________________________________',
                                          style: TextStyle(color: Colors.grey),
                                        ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13, top: 0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.home),
                                          Text(
                                              ' ${data['So Nha']} ${data['Ten Duong']}, ${data['Thanh Pho']}')
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      height: 210,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                          image: NetworkImage(data['image_0']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          // Content for Tab 2
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
                          Container(
                            color: const Color.fromARGB(255, 175, 76, 117),
                            child: Center(
                              child: Text('Tab 3 Content'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
