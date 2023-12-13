import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_thuetro/buttonnavigation/src/main.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     color: Colors.white,
//     home: ConformScrenn(),
//   ));
// }
class ConformScrenn extends StatefulWidget {
  String documentsend4 = DateTime.now().millisecond.toString();
  ConformScrenn({required this.documentsend4, super.key});

  @override
  State<ConformScrenn> createState() => _ConformScrennState();
}

class _ConformScrennState extends State<ConformScrenn> {
  final TextEditingController sdt = TextEditingController();
  final TextEditingController titlepost = TextEditingController();
  final TextEditingController content = TextEditingController();
  final TextEditingController timeopen = TextEditingController();
  final TextEditingController timeclose = TextEditingController();
  CollectionReference Post1 = FirebaseFirestore.instance.collection('Post');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userid;
  @override
  void initState() {
    super.initState();

    // Thực hiện các hành động bạn muốn khi màn hình được mở
    userid = _auth.currentUser?.uid; // Ví dụ: Lấy dữ liệu từ server
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
                child: Text(
              'ĐĂNG PHÒNG',
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
                      'Xác Nhận',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 0, top: 8.0, bottom: 0, right: 12.0),
                  width: 10.0,
                  height: 0,
                  decoration: BoxDecoration(),
                ),
                Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      'ĐIỆN THOẠI',
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
                  controller: sdt,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Nhập số điện thoại của bạn',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 0, top: 8.0, bottom: 0, right: 12.0),
                  width: 10.0,
                  height: 0,
                  decoration: BoxDecoration(),
                ),
                Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      'TIÊU ĐỀ BÀI ĐĂNG',
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
                  controller: titlepost,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'TIÊU ĐỀ BÀI ĐĂNG CỦA BẠN',
                      labelStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 0, top: 8.0, bottom: 0, right: 12.0),
                  width: 10.0,
                  height: 0,
                  decoration: BoxDecoration(),
                ),
                Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      'NỘI DUNG MÔ TẢ',
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
                  controller: content,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Nội Dung...',
                      labelStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          controller: timeopen,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Giờ mở cửa',
                              labelStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          controller: timeclose,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Giờ đóng cửa',
                              labelStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                    onPressed: () async {
                      await Post1.doc(widget.documentsend4)
                          .update({
                            'Dien thoai': sdt.text,
                            'tieu de bai dang': titlepost.text,
                            'noi dung mo ta': content.text,
                            'Gio mo cua': timeopen.text,
                            'Gio dong cua': timeclose.text,
                            'user id': '${_auth.currentUser?.uid}',
                          })
                          .then((value) =>
                              print("Success Added ${_auth.currentUser?.uid}"))
                          .catchError(
                              (error) => print("Failed to add data: $error"));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Example()),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      'ĐĂNG PHÒNG',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ),
    );
  }
}
