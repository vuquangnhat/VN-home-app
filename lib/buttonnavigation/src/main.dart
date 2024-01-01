import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../Screen/accountpage.dart';
import '../../Screen/homepage.dart';
import '../../Screen/thongtin.dart';
import '../../chat/screens/all_chat_screen.dart';
import '../../chat/screens/profile_screen.dart';

// void main() async{
//     WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//  runApp(MaterialApp(
//     debugShowCheckedModeBanner: false ,
//     builder: (context, child) {
//       return Directionality(textDirection: TextDirection.ltr, child: child!);
//     },
//     title: 'GNav',
//     theme: ThemeData(
//       primaryColor: Colors.grey[800],
//     ),
//     home: Example()));
// }

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    thongtinScreen(),
    AllChatScreen(),
    // ProfileScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 246, 246),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Color.fromARGB(255, 12, 1, 1).withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
            child: GNav(
              rippleColor: Color.fromRGBO(196, 189, 217, 0.5),
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Color.fromRGBO(0, 0, 0, 1), //màu chữ khi hoạt động
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor:
                  Color.fromRGBO(162, 198, 252, 1), //màu lúc đucowj chọn
              color: Color.fromRGBO(205, 203, 203, 1), //màu lúc chưa hoạt động
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Trang Chủ',
                    textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight:  FontWeight.bold // Điều chỉnh giá trị theo ý muốn
                    // Các thuộc tính khác của TextStyle nếu cần
                  ),
                ),
                GButton(
                  icon: Icons.local_post_office,
                  text: 'Đăng Bài',
                    textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight:  FontWeight.bold // Điều chỉnh giá trị theo ý muốn
                    // Các thuộc tính khác của TextStyle nếu cần
                  ),
                ),
                GButton(
                  icon: Icons.chat_bubble,
                  text: 'Chat',
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight:  FontWeight.bold // Điều chỉnh giá trị theo ý muốn
                    // Các thuộc tính khác của TextStyle nếu cần
                  ),
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Tài Khoản',
                    textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight:  FontWeight.bold // Điều chỉnh giá trị theo ý muốn
                    // Các thuộc tính khác của TextStyle nếu cần
                  ),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
