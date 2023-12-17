import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../component/listviewsearch.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     color: Colors.white,
//     home: Pagesearch(),
//   ));
// }

// ignore: must_be_immutable
class Pagesearch extends StatefulWidget {
  double tienthue = 0;
  List ds_tienich = [];
  int songuoi = 1;
  String? gioitinh;
  String? loaiphong;
  Pagesearch(
      {super.key,
      required this.ds_tienich,
      required  this.songuoi,
      required this.gioitinh,
      required  this.tienthue, required  this.loaiphong});

  @override
  State<Pagesearch> createState() => _PagesearchState();
}

class _PagesearchState extends State<Pagesearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListviewSearch(tienthue: widget.tienthue,ds_tienich: widget.ds_tienich,songuoi: widget.songuoi,gioitinh: widget.gioitinh,loaiphong: widget.loaiphong),
    );
  }
}
