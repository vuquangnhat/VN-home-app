// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_thuetro/Screen/xacnhan.dart';

import 'package:test_thuetro/component/checkbox.dart';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     color: Colors.white,
//     home: Tienich(),
//   ));
// }

class Tienich extends StatefulWidget {
  String documentsend3 = DateTime.now().millisecond.toString();
  Map<String, bool> values = {
    'WC riêng': false,
    'An ninh': false,
    'Chỗ để xe': false,
    'Wifi': false,
    'Giờ giấc tự do': false,
    'Máy lạnh': false,
    'Nhà bếp': false,
    'Nước nóng': false,
    'Tủ lạnh': false,
    'Nội thất': false,
  };



  Tienich({
    required this.documentsend3,
    Key? key,
  
  }) : super(key: key);

  @override
  State<Tienich> createState() => _TienichState();
}

class _TienichState extends State<Tienich> {
//   CheckboxListtitle checkboxList = CheckboxListtitle();
//   Map<String, bool> getCheckboxValuesFromChild() {
//   return checkboxList.getCheckboxValues();
// }
  String imageUrl = '';
  List<String> imageUrls = [];
  GlobalKey<FormState> key = GlobalKey();
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('Post');
  List<String> tienich_list = [];
  final ImagePicker imgpicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                      child: Text(
                    'ĐĂNG PHÒNG',
                    style: TextStyle(fontSize: 25),
                  )),
                )
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              height: 200,
              width: 500,
              child: ListView.builder(
                scrollDirection: flipAxis(Axis.vertical), // Cuộn ngang
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(0),
                    child: Ink.image(
                      image: FileImage(File(imageUrls[index])),
                      width: 400,
                      height: 50,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 0.0, top: 8.0, bottom: 8.0, right: 12.0),
                  width: 5.0,
                  height: 5.0,
                  decoration: BoxDecoration(),
                ),
                OutlinedButton.icon(
                    onPressed: () async {
                      /*Step 1:Pick image*/
                      //Install image_picker
                      //Import the corresponding library
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.camera);
                      print('${file?.path}');
                      if (file != null) {
                        setState(() {
                          imageUrls.add(file.path);
                        });
                      } else {
                        print('khong co tam anh nao duoc chon');
                      }
                      for (int i = 0; i < imageUrls.length; i++) {
                          //Get a reference to storage root
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        //tao duong dan luu tru cho anh tren storage
                        Reference referenceDirImages =
                            referenceRoot.child('images');
                        String name = DateTime.now().toString();
                        //Create a reference for the image to be stored
                        Reference referenceImageToUpload =
                            referenceDirImages.child('$name');
                        //tai hinh anh len stored
                        await referenceImageToUpload.putFile(File(file!.path));
                        //lay URL
                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                        //day du lieu URL len cloud fire stored
                        Map<String, String> dataToSend = {
                          'image_$i': imageUrl,
                        };
                        _reference.doc(widget.documentsend3).update(dataToSend);
                        print('them thanh cong ');
                        //Handle errors/success
                      }
                    },
                    icon: Icon(Icons.camera_alt_sharp),
                    label: Text('Chụp hình'))
              ],
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
                      'TIỆN ÍCH',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            //list check box
            SizedBox(
                height: 300,
                child: ListView(
                  children: widget.values.keys.map((String key) {
                    return CheckboxListTile(
                      title: Text(key),
                      value: widget.values[key],
                      onChanged: (bool? value) {
                        setState(() {
                          widget.values[key] = value!;
                          if (widget.values[key] == true) {
                            print(key);
                            tienich_list.add(key); // Thêm key vào danh sách
                            print('them thanh cong ');
                            // Cập nhật trường kiểu mảng trên Firebase
                            _reference.doc('Property1').update(
                                {'tienich_list': tienich_list}).then((_) {
                              print('Cập nhật danh sách thành công');
                            }).catchError((error) {
                              print('Lỗi khi cập nhật danh sách: $error');
                            });
                          } else if (widget.values[key] == false) {
                            tienich_list.remove(key); // Xóa key khỏi danh sách
                            print('da bo chon $key');

                            // Cập nhật trường kiểu mảng trên Firebase
                            _reference.doc(widget.documentsend3).update(
                                {'tienich_list': tienich_list}).then((_) {
                              print('Cập nhật danh sách thành công');
                            }).catchError((error) {
                              print('Lỗi khi cập nhật danh sách: $error');
                            });
                          }
                        });
                      },
                    );
                  }).toList(),
                )),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () async {   Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConformScrenn(documentsend4: widget.documentsend3,
                              )),
                    );}, child: Text('Tiếp Theo')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
