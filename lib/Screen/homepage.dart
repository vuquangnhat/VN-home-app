import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_thuetro/component/listviewmost.dart';
import 'package:test_thuetro/component/listviewpost.dart';

import '../component/listtile.dart';
import '../component/listviewsearch.dart';
import 'Pagesearch.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     color: Colors.white,
//     home: HomePage(),
//   ));
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(28, 107, 253, 1),
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                  child: Text(
                'Vn Home',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black87,
                        offset: Offset(0.3, 0.3),
                      )
                    ]),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 160,
                left: 22,
              ),
              child: Container(
                height: 200,
                width: 345,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 248, 248, 248),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 15),
                      child: const Text(
                        'Tìm Kiếm Mọi Lúc',
                        style: TextStyle(color: Color.fromRGBO(97, 97, 97, 1)),
                      ),
                    ),
                    //thanh tiem kiem
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 50),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.location_on,
                                color: Color.fromRGBO(36, 107, 253, 1)),
                            onPressed: () {
                              // Xử lý khi nhấn vào nút đầu tiên
                            },
                          ),
                          Expanded(
                            child: Container(
                              height: 35,
                              child: TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search_outlined,
                                    color: const Color.fromRGBO(28, 107, 253, 1),
                                  ),
                                  hintText: 'Bạn muốn tìm kiếm gì ',
                                  hintStyle:
                                      TextStyle(color: Colors.grey, fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.filter_list_alt,
                                color: Color.fromRGBO(36, 107, 253, 1)),
                            onPressed: () {
                              // Xử lý khi nhấn vào nút thứ hai
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 120, left: 46),
                      child: Container(
                          width: 257,
                          height: 30,
                          child: ElevatedButton(
                              onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => Pagesearch(),
                                  //     ));
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(28, 107, 253, 1),
                                ),
                              ),
                              child: Text('TÌM KIẾM NGAY'))),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 380,left: 30,),
              child: Text('XU HƯỚNG',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 400,left: 30),
              child: Container(
                height: 350,
                width: 330,
                
                child: Listviewhorizotal(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 760,left: 30),
              child: Text('ĐỀ XUẤT DÀNH CHO BẠN',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 780,left: 30),
              child: ListviewRecomand(),
            ),
          ],
        ),
    );
    
  }
}
