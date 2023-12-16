import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_thuetro/Screen/diachi.dart';
import 'package:test_thuetro/savepicture/item_details.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     color: Colors.white,
//     home: ListviewRecomand(),
//   ));
// }

class ListviewRecomand extends StatefulWidget {
  const ListviewRecomand({super.key});

  @override
  State<ListviewRecomand> createState() => _ListviewRecomandState();
}

class _ListviewRecomandState extends State<ListviewRecomand> {
  List<Map> _filteredItems = [];
  List<Map> items = [];
  List<dynamic> tienich_list = [];
  void initState() {
    super.initState();
    featch();
  }
  Future<void> featch() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('Post')
          .where('Thanh Pho', isEqualTo: 'ĐÀ NẴNG')
          .get();

  setState(() {
    items = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> document) {
      return document.data()!;
    }).toList();
    _filteredItems = items;
  });
}
  // Recomanpost(String value) {
  //   print(value);
  //   _filteredItems = List<Map>.from(items);
  //   setState(() {
  //     _filteredItems = items
  //         .where((item) => item['Ten Duong']
  //             .toLowerCase()
  //             .contains(value.toLowerCase()))
  //         .toList();
  //     print('Here: ${_filteredItems.length}');
  //   });
  //   print(_filteredItems);
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection:
                  Axis.vertical, // Set the scroll direction to horizontal
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
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: double.infinity,
                        height : 85,
                        child: Stack(children: [
                          Container(
                            width: 80,
                            height: 100,
                            
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(thisItem['image_0'],width: 80,height: 100,fit: BoxFit.cover,))),
                          Padding(
                            padding: const EdgeInsets.only(left: 90),
                            child:  Text(thisItem['tieu de bai dang'],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                   
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 90,top: 30),
                            child: Text('Giá Cho Thuê: '+thisItem['Giachothue']+'/Tháng',style: TextStyle(color: Color.fromRGBO(10, 142, 217, 1)),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 90,top: 65),
                            child:  Text('Địa Chỉ: ${thisItem['So Nha']} ${thisItem['Ten Duong']}, ${thisItem['Thanh Pho']}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                          ),
                        ]),
                      ),
                    )
                  );
                }
              })
        ],
      );
  }
}
