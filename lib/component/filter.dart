import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_thuetro/Screen/Pagesearch.dart';

import 'listviewsearch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home  : FliterPage(),
  ));
}

class FliterPage extends StatefulWidget {
  const FliterPage({super.key});

  @override
  State<FliterPage> createState() => _FliterPageState();
}

class _FliterPageState extends State<FliterPage> {
  double tienthue = 0;
  double min = 0; 
  double max = 10;
  bool wc_state = false;
  bool an_state = false;
  bool chodexe_state = false;
  bool wifi_state = false;
  bool maylanh_state = false;
  bool nhabep_state = false;
  bool nuocnong_state = false;
  bool tulanh_state = false;
  bool noithat_state = false;
  String valuebutton = '';
  String wcrieng = 'WC riêng';
  String anninh = 'An ninh';
  String chodexe = 'Chỗ để xe';
  String wifi = 'Wifi';
  String maylanh = 'Máy lạnh';
  String nhabep = 'Nhà bếp';
  String nuocnong = 'Nước nóng';
  String tulanh = 'Tủ lạnh';
  String noithat = 'Nội thất';
  String? typeofhome;
  int songuoi = 1;
  String? gioitinh;
  List ds_tienich = [];
  Map state = {};
  void wcbutton(String value) {
    setState(() {
      // Đảo ngược trạng thái khi nút được click
      wc_state = !wc_state;
      if (wc_state == true) {
        valuebutton = value;
        print(valuebutton);
        ds_tienich.add(valuebutton);
        print('ds tien ich $ds_tienich');
      } else {
        ds_tienich.remove(valuebutton);
        valuebutton = '';
        print(valuebutton);
        print('ds tien ich $ds_tienich');
      }
    });
  }

  void anninhbutton(String value) {
    setState(() {
      // Đảo ngược trạng thái khi nút được click
      an_state = !an_state;
      if (an_state == true) {
        valuebutton = value;
        print(valuebutton);
        ds_tienich.add(valuebutton);
        print('ds tien ich $ds_tienich');
      } else {
        ds_tienich.remove(valuebutton);

        print(valuebutton);
        valuebutton = '';
        print('ds tien ich $ds_tienich');
      }
    });
  }

  void chodexebutton(String value) {
    setState(() {
      // Đảo ngược trạng thái khi nút được click
      chodexe_state = !chodexe_state;
      if (chodexe_state == true) {
        valuebutton = value;
        print(valuebutton);
        ds_tienich.add(valuebutton);
        print('ds tien ich $ds_tienich');
      } else {
        ds_tienich.remove(valuebutton);

        print(valuebutton);
        valuebutton = '';
        print('ds tien ich $ds_tienich');
      }
    });
  }

  void wifibutton(String value) {
    setState(() {
      // Đảo ngược trạng thái khi nút được click
      wifi_state = !wifi_state;
      if (chodexe_state == true) {
        valuebutton = value;
        print(valuebutton);
        ds_tienich.add(valuebutton);
        print('ds tien ich $ds_tienich');
      } else {
        ds_tienich.remove(valuebutton);

        print(valuebutton);
        valuebutton = '';
        print('ds tien ich $ds_tienich');
      }
    });
  }

  void maylanhbutton(String value) {
    setState(() {
      // Đảo ngược trạng thái khi nút được click
      maylanh_state = !maylanh_state;
      if (maylanh_state == true) {
        valuebutton = value;
        print(valuebutton);
        ds_tienich.add(valuebutton);
        print('ds tien ich $ds_tienich');
      } else {
        ds_tienich.remove(valuebutton);
        print(valuebutton);
        valuebutton = '';
        print('ds tien ich $ds_tienich');
      }
    });
  }

  void nhabepbutton(String value) {
    setState(() {
      // Đảo ngược trạng thái khi nút được click
      nhabep_state = !nhabep_state;
      if (nhabep_state == true) {
        valuebutton = value;
        print(valuebutton);
        ds_tienich.add(valuebutton);
        print('ds tien ich $ds_tienich');
      } else {
        ds_tienich.remove(valuebutton);
        print(valuebutton);
        valuebutton = '';
        print('ds tien ich $ds_tienich');
      }
    });
  }

  void nuocnongbutton(String value) {
    setState(() {
      // Đảo ngược trạng thái khi nút được click
      nuocnong_state = !nuocnong_state;
      if (nuocnong_state == true) {
        valuebutton = value;
        print(valuebutton);
        ds_tienich.add(valuebutton);
        print('ds tien ich $ds_tienich');
      } else {
        ds_tienich.remove(valuebutton);
        print(valuebutton);
        valuebutton = '';
        print('ds tien ich $ds_tienich');
      }
    });
  }

  void tulanhbutton(String value) {
    setState(() {
      // Đảo ngược trạng thái khi nút được click
      tulanh_state = !tulanh_state;
      if (tulanh_state == true) {
        valuebutton = value;
        print(valuebutton);
        ds_tienich.add(valuebutton);
        print('ds tien ich $ds_tienich');
      } else {
        ds_tienich.remove(valuebutton);
        print(valuebutton);
        valuebutton = '';
        print('ds tien ich $ds_tienich');
      }
    });
  }

  void noithatbutton(String value) {
    setState(() {
      // Đảo ngược trạng thái khi nút được click
      noithat_state = !noithat_state;
      if (noithat_state == true) {
        valuebutton = value;
        print(valuebutton);
        ds_tienich.add(valuebutton);
        print('ds tien ich $ds_tienich');
      } else {
        ds_tienich.remove(valuebutton);
        print(valuebutton);
        valuebutton = '';
        print('ds tien ich $ds_tienich');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Giá Phòng',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 230),
                          child: Text('$tienthue VND'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Slider(
                      min: min,
                      max: max,
                      divisions: 10,
                      value: tienthue,
                      onChanged: (value) {
                        setState(() {
                          tienthue = value;
                          print(tienthue);
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text('Tiện Ích',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nút được click
                              wcbutton(wcrieng);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  // Điều chỉnh màu sắc của nút dựa trên trạng thái
                                  return wc_state ? Colors.blue : Colors.white;
                                },
                              ),
                            ),
                            child: Text(
                              '$wcrieng',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nút được click
                              anninhbutton(anninh);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  // Điều chỉnh màu sắc của nút dựa trên trạng thái
                                  return an_state ? Colors.blue : Colors.white;
                                },
                              ),
                            ),
                            child: Text(
                              '$anninh',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nút được click
                              chodexebutton(chodexe);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  // Điều chỉnh màu sắc của nút dựa trên trạng thái
                                  return chodexe_state
                                      ? Colors.blue
                                      : Colors.white;
                                },
                              ),
                            ),
                            child: Text(
                              '$chodexe',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nút được click
                              maylanhbutton(maylanh);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  // Điều chỉnh màu sắc của nút dựa trên trạng thái
                                  return maylanh_state
                                      ? Colors.blue
                                      : Colors.white;
                                },
                              ),
                            ),
                            child: Text(
                              '$maylanh',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nút được click
                              nhabepbutton(nhabep);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  // Điều chỉnh màu sắc của nút dựa trên trạng thái
                                  return nhabep_state
                                      ? Colors.blue
                                      : Colors.white;
                                },
                              ),
                            ),
                            child: Text(
                              '$nhabep',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nút được click
                              nuocnongbutton(nuocnong);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  // Điều chỉnh màu sắc của nút dựa trên trạng thái
                                  return nuocnong_state
                                      ? Colors.blue
                                      : Colors.white;
                                },
                              ),
                            ),
                            child: Text(
                              '$nuocnong',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý khi nút được click
                            tulanhbutton(tulanh);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                // Điều chỉnh màu sắc của nút dựa trên trạng thái
                                return tulanh_state
                                    ? Colors.blue
                                    : Colors.white;
                              },
                            ),
                          ),
                          child: Text(
                            '$tulanh',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 34),
                          child: ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nút được click
                              noithatbutton(noithat);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  // Điều chỉnh màu sắc của nút dựa trên trạng thái
                                  return noithat_state
                                      ? Colors.blue
                                      : Colors.white;
                                },
                              ),
                            ),
                            child: Text(
                              '$noithat',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý khi nút được click
                            wifibutton(wifi);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                // Điều chỉnh màu sắc của nút dựa trên trạng thái
                                return wifi_state ? Colors.blue : Colors.white;
                              },
                            ),
                          ),
                          child: Text(
                            '$wifi',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Loại Phòng',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    RadioListTile(
                      title: Text("Kí túc xá/Homestay"),
                      value: "kí túc xá/Homestay",
                      groupValue: typeofhome,
                      onChanged: (value) {
                        setState(() {
                          typeofhome = value.toString();
                          print('$typeofhome');
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Phòng cho thuê"),
                      value: "Phòng cho thuê",
                      groupValue: typeofhome,
                      onChanged: (value) {
                        setState(() {
                          typeofhome = value.toString();
                          print('$typeofhome');
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Phòng ở ghép"),
                      value: "Phòng ở ghép",
                      groupValue: typeofhome,
                      onChanged: (value) {
                        setState(() {
                          typeofhome = value.toString();
                          print('$typeofhome');
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Nhà nguyên căn"),
                      value: "Nhà nguyên căn",
                      groupValue: typeofhome,
                      onChanged: (value) {
                        setState(() {
                          typeofhome = value.toString();
                          print('$typeofhome');
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Căn hộ"),
                      value: "Căn hộ",
                      groupValue: typeofhome,
                      onChanged: (value) {
                        setState(() {
                          typeofhome = value.toString();
                          print('$typeofhome');
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Số Người',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // IconButton(
                            //     onPressed: () {
                            //       setState(() {
                            //         songuoi = songuoi + 1;
                            //         print(songuoi);
                            //       });
                            //     },
                            //     icon: Icon(Icons.add_box_rounded)),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      songuoi = songuoi + 1;
                                      print(songuoi);
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/icons_plus.png',
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.cover,
                                  )),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                '$songuoi',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            // IconButton(
                            //     onPressed: () {
                            //       setState(() {
                            //         songuoi = songuoi - 1;
                            //         if (songuoi < 1) {
                            //           Fluttertoast.showToast(
                            //               msg: "Số người không thể nhỏ hơn 1",
                            //               toastLength: Toast.LENGTH_SHORT,
                            //               gravity: ToastGravity.BOTTOM,
                            //               timeInSecForIosWeb: 0,
                            //               backgroundColor:
                            //                   const Color.fromARGB(255, 8, 8, 8),
                            //               textColor: Colors.white,
                            //               fontSize: 16.0);
                            //           songuoi = 1;
                            //         }
                            //         print(songuoi);
                            //       });
                            //     },
                            //     icon: Icon(Icons.exposure_minus_1)),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    songuoi = songuoi - 1;
                                    if (songuoi < 1) {
                                      Fluttertoast.showToast(
                                          msg: "Số người không thể nhỏ hơn 1",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 0,
                                          backgroundColor: const Color.fromARGB(
                                              255, 8, 8, 8),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      songuoi = 1;
                                    }
                                    print(songuoi);
                                  });
                                },
                                child: Image.asset(
                                  'assets/icons_minus.png',
                                  height: 35,
                                  width: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Giới Tính',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    RadioListTile(
                      title: Text("Tất cả"),
                      value: "Tất cả",
                      groupValue: gioitinh,
                      onChanged: (value) {
                        setState(() {
                          gioitinh = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Nam"),
                      value: "Nam",
                      groupValue: gioitinh,
                      onChanged: (value) {
                        setState(() {
                          gioitinh = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Nữ"),
                      value: "Nữ",
                      groupValue: gioitinh,
                      onChanged: (value) {
                        setState(() {
                          gioitinh = value.toString();
                        });
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pagesearch(
                                    tienthue: tienthue,
                                    ds_tienich: ds_tienich,
                                    gioitinh: gioitinh,
                                    songuoi: songuoi,
                                    loaiphong: typeofhome),
                              ));
                        },
                        child: Text('Áp Dụng'))
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
