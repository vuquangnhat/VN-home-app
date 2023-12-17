// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:test_thuetro/savepicture/item_details.dart';

class ListviewSearch extends StatefulWidget {
  double tienthue = 0;
  List ds_tienich = [];
  int songuoi = 1;
  String? gioitinh;
  String? loaiphong;
  ListviewSearch(
      {key,
      required this.tienthue,
      required this.ds_tienich,
      required this.songuoi,
      required this.gioitinh,
      required this.loaiphong})
      : super(key: key);

  @override
  State<ListviewSearch> createState() => _ListviewSearchState();
}

class _ListviewSearchState extends State<ListviewSearch> with AutomaticKeepAliveClientMixin {
  List<Map> _filteredItems = [];
  List<Map> items = [];

  @override
  bool get wantKeepAlive => true;
  void initState() {
    super.initState();
    featch().whenComplete(() => searchfiler());
  }

  Future<void> featch() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Post').get();

      items = await querySnapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> document) {
        return document.data()!;
      }).toList();
      _filteredItems = items;
    setState(() {
    });
  }

  searchfiler() {
    print(widget.songuoi);
    _filteredItems = List.from(items);
    setState(() {
      _filteredItems = items
    .where((item) =>
        item['LoaiPhong'] 
            .toLowerCase()
            .contains('${widget.loaiphong}'.toLowerCase()) &&
        item['tienich_list'].any((item2) =>
            widget.ds_tienich.any((element) => element.toString() == item2))
         && item['Giachothue'] <= widget.tienthue
            )
    .toList();

      _filteredItems.forEach((element) => print('here1: ${element['LoaiPhong']}'),);
      print('Here: ${_filteredItems.length}');
    });
    print(_filteredItems);
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
    return Stack(
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
                    search(value);
                    print(widget.ds_tienich);
                    print(widget.loaiphong);
                    // searchfiler(value);
                  },
                  style: GoogleFonts.poppins(
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
                    hintStyle: GoogleFonts.poppins(
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
    );
  }
}
