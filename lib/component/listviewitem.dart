import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_thuetro/Screen/tienich.dart';
import 'package:test_thuetro/savepicture/item_details.dart';

// ignore: must_be_immutable
class Listviewitem extends StatefulWidget {
  double tienthue = 0;
  List ds_tienich = [];
  int songuoi = 1;
  String? gioitinh;
  Listviewitem(
      {
      super.key});

  @override
  State<Listviewitem> createState() => _ListviewitemState();
}

class _ListviewitemState extends State<Listviewitem> {
  List<Map> _filteredItems = [];
  List<Map> items = [];
  void initState() {
    super.initState();
    featch();
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

  search(String value) {
    print(value);
    _filteredItems = List<Map>.from(items);
    setState(() {
      _filteredItems = items
          .where((item) =>
              item['Ten Duong'].toLowerCase().contains(value.toLowerCase()) ||
              item['Thanh Pho'].toLowerCase().contains(value.toLowerCase()) ||
              item['LoaiPhong'].toLowerCase().contains(value.toLowerCase()))
          .toList();
      print('Here: ${_filteredItems.length}');
    });
    print(_filteredItems);
  }
//con c
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                  width: 360,
                  child: TextField(
                    // controller: editingController,
                    onChanged: (value) {
                      // FilterModel fmodel = FilterModel(cityName: 'HÀ NỘI', streetName: "", money: 300, dau: '');
                      // filter(fmodel);
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
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: _filteredItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        //Get the item at this index
                        Map thisItem = _filteredItems[index];
                        if (thisItem['image_0'] != null &&
                            thisItem['image_0'] is String) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ItemDetails(thisItem['Post ID'])));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 20),
                              height: 210,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.5),
                                      blurRadius: 5,
                                      offset: Offset(0, 3))
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(thisItem['image_0']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 20, left: 20),
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
                                  Stack(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(30),
                                                bottomRight: Radius.circular(30)),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.8),
                                                Colors.transparent
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            )),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Column(
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
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        ;
                      }),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
