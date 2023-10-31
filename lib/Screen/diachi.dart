// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_thuetro/Screen/tienich.dart';
import 'package:test_thuetro/Screen/xacnhan.dart';

import 'package:test_thuetro/component/dropdown_button.dart';

// void main() async {
//     WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: DiachiScreen(),
//   ));
// }
class DiachiScreen extends StatefulWidget {
  List<String> list = <String>['HÀ NỘI', 'ĐÀ NẴNG', 'HỒ CHÍ MINH'];
  String documentsend2 = DateTime.now().millisecond.toString();

  DiachiScreen({required this.documentsend2, super.key});

 
  @override
  State<DiachiScreen> createState() => _DiachiScreenState();
}

class _DiachiScreenState extends State<DiachiScreen> {
  String dropdownValue = list.first;
  final TextEditingController tenduongctl = TextEditingController();
  final TextEditingController sonhactl = TextEditingController();
   CollectionReference Post1 =
                                FirebaseFirestore.instance.collection('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 50,
          ),

          Center(
              child: Text(
            'Đăng Phòng',
            style: TextStyle(fontSize: 25),
          )),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 0.0, top: 8.0, bottom: 8.0, right: 12.0),
                width: 5.0,
                height: 5.0,
                decoration: BoxDecoration(),
              ),
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    'Địa Chỉ',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 12.0),
                width: 10.0,
                height: 0,
                decoration: BoxDecoration(),
              ),
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    'THÀNH PHỐ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: SizedBox(
              width: 350,
              child: SizedBox(
                width: 350,
                child: DropdownMenu<String>(
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                      print('$dropdownValue');
                    });
                  },
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 12.0),
                width: 10.0,
                height: 0,
                decoration: BoxDecoration(),
              ),
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    'TÊN ĐƯỜNG',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: SizedBox(
              width: 350,
              child: TextField(
                controller: tenduongctl,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: '',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 12.0),
                width: 10.0,
                height: 0,
                decoration: BoxDecoration(),
              ),
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    'SỐ NHÀ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: SizedBox(
              width: 350,
              child: TextField(
                controller: sonhactl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: '',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: ()async {
                            await Post1.doc(widget.documentsend2)
                                .update({
                                  'Thanh Pho': dropdownValue.toString(),
                                  'Ten Duong': tenduongctl.text,
                                  'So Nha': sonhactl.text,
                                })
                                .then((value) => print("Success Added"))
                                .catchError((error) =>
                                    print("Failed to add data: $error"));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Tienich(
                            documentsend3: widget.documentsend2,
                              )),
                    );
                  },
                  child: Text('Tiếp Theo'))
            ],
          )
        ]),
      ),
    );
  }
}
