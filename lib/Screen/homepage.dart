import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_thuetro/Screen/thongtin.dart';

import 'package:test_thuetro/component/listviewmost.dart';
import 'package:test_thuetro/component/listviewpost.dart';
import 'package:test_thuetro/test/filter.dart';

import '../chat/screens/all_chat_screen.dart';
import '../component/filter.dart';
import '../component/listview_recomand.dart';
import '../component/listviewitem.dart';
import '../component/listviewsearch.dart';
import '../component/search.dart';
import 'Pagesearch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<String> list_thanhpho = <String>['ĐÀ NẴNG', 'HÀ NỘI', 'HỒ CHÍ MINH'];
  String dropdownValue = '';
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Color.fromARGB(255, 247, 246, 246)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 65.0, left: 10),
            child: Row(
              children: [
                Text(
                  'Chào, ',
                  style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 0, 0, 0)),
                ),
                Text(
                  'Nhật',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(width: 200),
                Container(
                    height: 40,
                    width: 50,
                    child: CircleAvatar(
                      radius: 10,
                      child: Text('N', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.orange,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 125.0, left: 0),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Image.asset('assets/vnhome.jpg')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 290, left: 0),
            child: Container(
              width: double.infinity,
              height: 800,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 247, 246, 246),
              ),
              child: Column(children: [
                TabBar.secondary(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        'Chức Năng',
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Xu Hướng',
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Đề Xuất Cho Bạn',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                indicator: BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 5,
      offset: Offset(0, 3),
    ),
  ],
  color: Colors.white,
),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      //content tab1
                      SingleChildScrollView(
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Searchtitle()),
                                    );
                                    print('object');
                                  },
                                  child: Container(
                                    height: 200,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // Chỉnh độ lệch của shadow theo trục x và y
                                        ),
                                      ],
                                    ),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(Icons.search,
                                                size: 45,
                                                color: Color.fromRGBO(
                                                    196, 189, 217, 1)),
                                          ),
                                          Icon(
                                            Icons.flash_on,
                                            size: 25,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              'Tìm Kiếm Trọ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              'Nhanh chóng',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              '______________________',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Container(
                                              width: 150,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Icon(Icons.search),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              //

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 200, top: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AllChatScreen()),
                                    );
                                  },
                                  child: Container(
                                    height: 200,
                                    width: 180,
                                 decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // Chỉnh độ lệch của shadow theo trục x và y
                                        ),
                                      ],
                                    ),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(Icons.chat_bubble,
                                                size: 45,
                                                color: Color.fromRGBO(
                                                    196, 189, 217, 1)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.speed,
                                              size: 25,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              'Chat',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              'Dễ Dàng',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              '______________________',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Container(
                                              width: 150,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Icon(Icons.chat_bubble),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              //

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 230),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              thongtinScreen()),
                                    );
                                    print('object3');
                                  },
                                  child: Container(
                                    height: 200,
                                    width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // Chỉnh độ lệch của shadow theo trục x và y
                                        ),
                                      ],
                                    ),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(Icons.add_box,
                                                size: 45,
                                                color: Color.fromRGBO(
                                                    196, 189, 217, 1)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.image,
                                              size: 25,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              'Đăng Bài',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              'Ngay Lập Tức',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              '______________________',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Container(
                                              width: 150,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Icon(Icons.add_box),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 200, top: 230),
                                child: GestureDetector(
                                  onTap: () {
                                    print('object2');
                                  },
                                  child: Container(
                                    height: 200,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // Chỉnh độ lệch của shadow theo trục x và y
                                        ),
                                      ],
                                    ),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(Icons.person_2,
                                                size: 45,
                                                color: Color.fromRGBO(
                                                    196, 189, 217, 1)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.speed,
                                              size: 25,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              'Tài Khoản',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              'Tiện Ích',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Text(
                                              '______________________',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 15),
                                            child: Container(
                                              width: 150,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Icon(Icons.person_pin),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      //xu huong
                      Container(
                          height: 500,
                          decoration: BoxDecoration(
                              color: Colors.transparent),
                          child: Listviewhorizotal()),
                      //de xuat cho ban
                      Container(
                          height: 500,
                          decoration: BoxDecoration(
                              color: Colors.transparent),
                          child: Listviewrecomand()),
                    ],
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    ));
  }
}
