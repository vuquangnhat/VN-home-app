import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:test_thuetro/Screen/reservationpage.dart';
import 'package:test_thuetro/chat/screens/login_screen.dart';

import 'bookmyroom.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map? account_list;
  String tennguoidung = '';
  String kitudau = '';
  String email = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fetchdatauser(_auth.currentUser!.uid);
  }

  Future<void> Fetchdatauser(String userId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    if (userId.isNotEmpty) {
      try {
        DocumentSnapshot userSnapshot =
            await firestore.collection('Users').doc(userId).get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          userData.forEach((key, value) {
            print('$key: $value');
          });
          account_list = userData;
          setState(() {
            tennguoidung = account_list?['username'] ?? 'Vũ Quang Nhật';
            kitudau = tennguoidung[0];
            email = account_list?['email'] ?? 'vuquangnhat@gmail.com';
            print(tennguoidung);
          });
        } else {
          print('Không tìm thấy user data name');
        }
      } catch (e) {
        print('Lỗi khi lấy user id từ post id: $e');
      }
    } else {
      print('userId là null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            height: 570,
            width: double.infinity,
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 250, 249, 249)),
            child: Column(
              children: [
                Text(
                  'Tài Khoản',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                      height: 70,
                      width: 70,
                      child: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text(
                          '$kitudau',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    '$tennguoidung',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                  child: Container(
                    height: 60,
                    width: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(0.1), // Màu của shadow
                          spreadRadius: 2, // Bán kính lan rộng của shadow
                          blurRadius: 5, // Độ mờ của shadow
                          offset: Offset(0, 3), // Độ dịch chuyển của shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Thông Tin Tài Khoản',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 80),
                          child: Icon(
                            Icons.navigate_next_outlined,
                            size: 40,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => UsePaypal(
                              sandboxMode: true,
                              clientId:
                                  "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                              secretKey:
                                  "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                              returnURL: "https://samplesite.com/return",
                              cancelURL: "https://samplesite.com/cancel",
                              transactions: const [
                                {
                                  "amount": {
                                    "total": '10.12',
                                    "currency": "USD",
                                    "details": {
                                      "subtotal": '10.12',
                                      "shipping": '0',
                                      "shipping_discount": 0
                                    }
                                  },
                                  "description":
                                      "The payment transaction description.",
                                  // "payment_options": {
                                  //   "allowed_payment_method":
                                  //       "INSTANT_FUNDING_SOURCE"
                                  // },
                                  "item_list": {
                                    "items": [
                                      {
                                        "name": "A demo product",
                                        "quantity": 1,
                                        "price": '10.12',
                                        "currency": "USD"
                                      }
                                    ],

                                    // shipping address is not required though
                                    "shipping_address": {
                                      "recipient_name": "Jane Foster",
                                      "line1": "Travis County",
                                      "line2": "",
                                      "city": "Austin",
                                      "country_code": "US",
                                      "postal_code": "73301",
                                      "phone": "+00000000",
                                      "state": "Texas"
                                    },
                                  }
                                }
                              ],
                              note:
                                  "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                print("onSuccess: $params");
                                print('aaa: ${params['paymentId']}');
                                AlertDialog(
  title: Text('Chuyển tiền thành công'),
  content: Text('Giao dịch chuyển tiền đã được thực hiện thành công.'),
  actions: [
    TextButton(
      onPressed: () {
        // Xử lý sự kiện khi người dùng nhấn nút Đóng
        Navigator.pop(context);
      },
      child: Text('Đóng'),
    ),
  ],
);
                              },
                              onError: (error) {
                                print("onError: $error");
                              },
                              onCancel: (params) {
                                print('cancelled: $params');
                              }),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.1), // Màu của shadow
                            spreadRadius: 2, // Bán kính lan rộng của shadow
                            blurRadius: 5, // Độ mờ của shadow
                            offset: Offset(0, 3), // Độ dịch chuyển của shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.payments,
                            size: 40,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Phương Thức Thanh Toán',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 30),
                            child: Icon(
                              Icons.navigate_next_outlined,
                              size: 40,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Bookmyroom()),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.1), // Màu của shadow
                            spreadRadius: 2, // Bán kính lan rộng của shadow
                            blurRadius: 5, // Độ mờ của shadow
                            offset: Offset(0, 3), // Độ dịch chuyển của shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book,
                            size: 40,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Phòng Của Bạn Được Đặt',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 25),
                            child: Icon(
                              Icons.navigate_next_outlined,
                              size: 40,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReservationPage()),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.1), // Màu của shadow
                            spreadRadius: 2, // Bán kính lan rộng của shadow
                            blurRadius: 5, // Độ mờ của shadow
                            offset: Offset(0, 3), // Độ dịch chuyển của shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list_alt,
                            size: 40,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Danh Sách Phòng Đã Đặt',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 28),
                            child: Icon(
                              Icons.navigate_next_outlined,
                              size: 40,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                  child: Container(
                    height: 60,
                    width: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(0.1), // Màu của shadow
                          spreadRadius: 2, // Bán kính lan rộng của shadow
                          blurRadius: 5, // Độ mờ của shadow
                          offset: Offset(0, 3), // Độ dịch chuyển của shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance
                            .signOut()
                            .whenComplete(() => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false,
                                ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 40,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Thoát',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 215),
                            child: Icon(
                              Icons.navigate_next_outlined,
                              size: 40,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
