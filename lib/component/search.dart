// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_thuetro/component/filter.dart';

import 'package:test_thuetro/savepicture/item_details.dart';

class Searchtitle extends StatefulWidget {
  const Searchtitle({super.key});

  @override
  State<Searchtitle> createState() => _SearchtitleState();
}

class _SearchtitleState extends State<Searchtitle>
    with AutomaticKeepAliveClientMixin {
  List<Map> _filteredItems = [];
  List<Map> items = [];

  @override
  bool get wantKeepAlive => true;
  void initState() {
    super.initState();
    featch();
  }

  Future<void> featch() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Post').get();

    items = await querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> document) {
      return document.data()!;
    }).toList();
    _filteredItems = items;
    setState(() {});
  }

  search(String value) {
    print(value);

    setState(() {
      _filteredItems = items
          .where((item) =>
              item['tieu de bai dang'] != null &&
              item['tieu de bai dang']
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
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          height: 45,
                          width: 340,
                          child: TextField(
                            onChanged: (value) {
                              search(value);
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
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Tìm theo tiêu đề, tên đường",
                              hintStyle: TextStyle(
                                  color: const Color(0xffb2b2b2),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  decorationThickness: 6),
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 30,
                              ),
                              prefixIconColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FliterPage()),
                              );
                            },
                            child: Icon(
                              Icons.filter_alt,
                              size: 45,
                            )),
                      )
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis
                          .vertical, // Set the scroll direction to horizontal
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
                                child: Container(
                                  height: 450,
                                  width: 360,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Stack(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14, top: 10),
                                      child: Container(
                                        height: 200,
                                        width: 350,
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Color.fromRGBO(
                                                        104, 170, 251, 1))),
                                          ),
                                          Text(
                                            thisItem['Giachothue'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
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
                                          top: 370, left: 12),
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
                              ));
                        } else {
                      
                        }
                      },
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
